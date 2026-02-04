%{
This is the master initialization file for the Cyclone Robosub Simulink.
This is intended to be the one-stop-shop for setting up and running
simulations that are run purely in Matlab and Simulink.

This file can setup, run, plot, and save data from any simulation variant
that includes the _SIM extension in the project. Depending on how the host 
machine has been configured, this init may fail for _HIL and _CGN models.
For these it is recommended to create a custom init for each case. Whether
this init will work with Unreal Engine cosimulation is to be determined - 
that may need a custom init as well.

If you need to make significant modifications to this file, create a copy
instead and give it an extension such as init_variant and place it in init
archive.
%}

%% Housekeeping and Path Management
clc
close all
%clear all %slows down startup so don't uncomment this unless you have a good reason to

if(~exist('prj_path_list','var')) %refreshes the file path in case clear all was called
    prj_path_list = getProjectPaths();
end


%% Parameters
run('constants.m') %load all necessary constants into the workspace

%% Initial Conditions
%initial intertial position
xi_0 = 0;
yi_0 = 0;
zi_0 = 0;
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
ui_0 = 0;
vi_0 = 0;
wi_0 = 0;
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = 0;
theta_0 = 0;
psi_0 = 0;
Eul_0 = [phi_0; theta_0; psi_0];

%other attitude representations
Cib_0 = eul2rotm([psi_0,theta_0,phi_0],'ZYX');
q_0 = rotm2quat(Cib_0); 

%reorder because the scalar should be at the end for calcs in the sim
q_0 = [q_0(2); q_0(3); q_0(4); q_0(1)];

%initial angular velocity
wx_0 = 0;
wy_0 = 0;
wz_0 = 0;
wb_0 = [wx_0; wy_0; wz_0];

%pack initial state
X0 = [Ri_0;q_0;dRi_0;wb_0];

%% Test Conditions

%test_ft_list = [0 0 0 0 10 10 10 10];
%test_pwm_list = [1500 1500 1500 1500 1800 1800 1200 1200];
%assumes mission_file.txt is in the src/inits/ folder
mission_file_name = "mission_file.txt"; 

%name of the model to be ran
sim_select = "FF_Controller_SIM.slx";
%battery voltage if constant
const_voltage = 14;

%joystick input if constant
%const_joy = [0 0 0 0 0 1]'; %[Y, X ,Rise,Sink,Yaw,Pitch]

%% Simulation Parameters
%simulation duration
tspan = 5;

%simulation time step
dt_sim = 0.001;

%data saving rate
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim

%controller update rate
dt_control_target = 0.01;
dt_control = round((dt_control_target/dt_sim))*dt_sim; %make sure dt_control is a multiple of dt_sim

%flags are used to turn parts of the simulation on and off
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; 
do_torque_flag = 1; 
do_force_flag = 1; 
do_Fb_correction = 0; 
overwrite_mission_file_wp_flag = 0;
overwrite_mission_file_mode_flag = 0;

%mission file
mission_file_path = fullfile(prj_path_list.inits_path,mission_file_name);
mission_file = importMissionCSV(mission_file_path);

%control mode (valid options MODE_NONE - no control, 1 MODE FF - feedforward, 2, MODE_PID - feedback PID control)
mode_overwrite = 2;

%target state (only used if overwrite_mission_file_wp_flag = 1)
R_target = [0; 0; 0;];
Eul_target = [0; 0; 0];
state_overwrite = [R_target;Eul_target];

%tolerances
roll_error_tol = 5*pi/180;
pitch_error_tol = 5*pi/180;
yaw_error_tol = 5*pi/180;
w_tol = 0.1;

%% Simulation
%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput(sim_select);
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

%% Post Processing
plots = {"FT_list","FT_cmd_list","Ri, dRi, ddRi","pwm_cmd","Eul", "FTb, MTb"};
% plots = {"FTb, MTb", "Eul", "FT_cmd_list", "Ri, dRi, ddRi"};
plotAllOutputs(results,plots);
saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.Cib.Data,prj_path_list.temp_path,"test");
