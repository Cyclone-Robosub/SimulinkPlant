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
run('setup_plots.m')

%% Initial Conditions
%initial intertial position
xi_0 = 20*rand - 10;
yi_0 = 20*rand - 10;
zi_0 = 20*rand - 10;
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
ui_0 = 2*rand - 1;
vi_0 = 2*rand - 1;
wi_0 = 2*rand - 1;
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = pi*rand - pi/2;
theta_0 = pi*rand - pi/2;
psi_0 = pi*rand - pi/2;
Eul_0 = [phi_0; theta_0; psi_0];

%other attitude representations
Cib_0 = eul2rotm([psi_0,theta_0,phi_0],'ZYX');
q_0 = rotm2quat(Cib_0); 

%reorder because the scalar should be at the end for calcs in the sim
q_0 = [q_0(2); q_0(3); q_0(4); q_0(1)];

%initial angular velocity
wbx_0 = 1*rand - .5;
wby_0 = 1*rand - .5;
wbz_0 = 1*rand - .5;
wb_0 = [wbx_0; wby_0; wbz_0];

%pack initial state
X0 = [Ri_0;q_0;dRi_0;wb_0];

%% Monte Carlo Setup
%TBA

%% Test Conditions
%battery voltage
const_voltage = 15;

%Simple_Joystick_SIM
const_joy = [0 0 0 0 0 0]'; %[Y, X ,Rise,Sink,Yaw,Pitch]
FT_list_test = 10*[0 0 0 0 10 -10 10 -10]';
test_pwm_list = [1500 1500 1500 1500 1500 1500 1500 1500]';
%% Simulation Parameters
%simulation duration
tspan = 100;

%simulation time step
dt_sim = 1/1000;

%data saving rate
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim

%controller update rate
dt_control_target = 1/100;
dt_control = round((dt_control_target/dt_sim))*dt_sim; %make sure dt_control is a multiple of dt_sim

%flags are used to turn parts of the simulation on and off
% Plant
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; 
do_torque_flag = 1; 
do_force_flag = 1; 

% %target state (only used if overwrite_mission_file_wp_flag = 1)
% R_target = [0; 0; 0;];
% Eul_target = [0; 0; 0];
% state_overwrite = [R_target;Eul_target];

%tolerances
roll_error_tol = 5*pi/180;
pitch_error_tol = 5*pi/180;
yaw_error_tol = 5*pi/180;
w_tol = 0.1;

%assumes mission_file.txt is in the src/inits/ folder
mission_file_name = "mission_file.txt"; 

%name of the model to be ran
sim_select = "FB_Controller_SIM.slx";

%mission file
mission_file_path = fullfile(prj_path_list.inits_path,mission_file_name);
mission_file = importMissionCSV(mission_file_path);
%% Simulation
% data_file_prefix = string(datetime('now','Format','uu-MM-dd HH-mm-ss'));
% sim_file_path = fullfile(prj_path_list.user_data_path,data_file_prefix);
% if(~isfolder(sim_file_path))
%     mkdir(sim_file_path);
% end
% sim_mat_path = fullfile(sim_file_path,"results.mat");
% %set the name of the file path
% set_param('FB_Controller_SIM/To File','Filename',sim_mat_path);

%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput(sim_select);
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);


%% Post Processing
plot_names = {"Ri, dRi, ddRi","FT_list","Fb, Mb","FTb, MTb", "FB_force_moment_cmd", "Eul", "FB_FT_cmd_lists","pwm_cmd"};
plotAllOutputs(plots,results,plot_names);
% saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.Cib.Data,prj_path_list.temp_path,"test");
% saveOutputMat(results,prj_path_list.user_data_path,do_state_save_flag,do_gif_flag);