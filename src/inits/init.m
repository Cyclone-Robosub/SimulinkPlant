%{
This is the master initialization file for the Cyclone Robosub Simulink.
This is intended to be the one-stop-shop for setting up and running
simulations that are run purely in Matlab and Simulink.

This file can setup, run, plot, and save data from any simulation variant
that includes the _SIM extension in the project. Depending on how the host 
machine has been configured, this init may fail for _HIL and _CGN models.
For these it is recommended to create a custom init for each case. Whether
this init will work with Unreal Engine cosimulation is to be determined - 
that may need a custom init as well. This init has not yet been tested with
_UCS models that take advantage of Unreal Engine cosimulation.

If you need to make significant modifications to this file, create a copy
instead and give it an extension such as init_variant and place it in init
archive.
%}


%% Housekeeping and Path Management
clc
close all
clear all %slows down startup so don't uncomment this unless you have a good reason to

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
Eul_0 = [phi_0; theta_0; psi_0]; %[roll, pitch, yaw]

%other attitude representations
Cib_0 = eulToRotm(Eul_0);
q_0 = eulToQuat(Eul_0); %[vector; scalar]

%initial angular velocity
wbx_0 = 0;
wby_0 = 0;
wbz_0 = 0;
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
tspan = 60;

%simulation time step
dt_sim = 1/1000;

%data saving rate
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim

%controller update rate
dt_control_target = 1/100;
dt_control = round((dt_control_target/dt_sim))*dt_sim; %make sure dt_control is a multiple of dt_sim

%flags are used to turn parts of the simulation on and off
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; 
do_torque_flag = 1; 
do_force_flag = 1; 

%the mission file used for this sim
mission_file_name = "mission_file_v2.txt"; 

%name of the model to be simulated
sim_select = "FB_Controller_SIM.slx";

%setup for bus objects (necessary to use structures in Simulink)
run('setup_cmd_bus.m');

%import the mission text file as an array of cmd objects
mission_file_path = fullfile(prj_path_list.inits_path,mission_file_name);
mission = importMission(mission_file_path);

%% Simulation
% data_file_prefix = string(datetime('now','Format','uu-MM-dd HH-mm-ss'));
% sim_file_path = fullfile(prj_path_list.user_data_path,data_file_prefix);
% if(~isfolder(sim_file_path))
%     mkdir(sim_file_path);
% end
% sim_mat_path = fullfile(sim_file_path,"results.mat");
% %set the name of the file path
% set_param('FB_Controller_SIM/To File','Filename',sim_mat_path);

%setup the sim
simIn = Simulink.SimulationInput(sim_select);

%set the parameter `mission` containing all the cmd structures
mission = Simulink.Parameter(mission);
mission_param.DataType = 'Bus: cmd_bus';
simIn = simIn.setVariable('mission', mission);

%run the sim
results = sim(simIn);


%% Post Processing
run('setup_plots.m')

% Enter the names of all the plots as a comma separated cell array
% Refer to setup_plots.m to see the valid plot names
plot_names = {"X", "cmd_status", "mission_idx","hold_timer", "cmd_hold_time"};
plotAllOutputs(plots,results,plot_names);
saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.Cib.Data,prj_path_list.temp_path,"test");
% saveOutputMat(results,prj_path_list.user_data_path,do_state_save_flag,do_gif_flag);