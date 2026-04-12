%{
This is the master initialization file for the Cyclone Robosub Simulink.
This is intended to be the one-stop-shop for setting up and running
simulations that are run purely in Matlab and Simulink.

This file can setup, run, plot, and save data from any simulation variant
that includes the _SIM extension in the project. Depending on how the host
machine has been configured, this init may fail for _HIL, _CGN, _EST, and
_UCS models. For these it is recommended to create a custom init for each
case.

If you need to make significant modifications to this file, create a copy
instead and give it an extension such as init_variant and place it in init
archive.

To use this codebase successfully, make sure project_startup.m has been
added to the project settings and ran and that the project is open (i.e.
the Project tab is visible at the top of the screen).
%}


%% Housekeeping and Path Management
clc
close all
%clear all %slow, comment this out if you don't need it

%refreshes the file path in case clear all was called
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

%% Parameters
run('constants.m') %load all necessary constants into the workspace

%% Initial Conditions
%initial intertial position
xi_0 = 0; yi_0 = 0; zi_0 = 0;
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
ui_0 = 0; vi_0 = 0; wi_0 = 0;
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = 0; theta_0 = 0; psi_0 = 0;
Eul_0 = [phi_0; theta_0; psi_0]; %[roll, pitch, yaw]

%other attitude representations
Cib_0 = eulToRotm(Eul_0);
q_0 = eulToQuat(Eul_0); %[vector; scalar]

%initial angular velocity
wbx_0 = 0; wby_0 = 0; wbz_0 = 0;
wb_0 = [wbx_0; wby_0; wbz_0];

%pack initial state
X0 = [Ri_0;q_0;dRi_0;wb_0];

%% Monte Carlo Setup
%TBA

%% Test Conditions
% Not all test conditions are needed for every model

%battery voltage
const_voltage = 15;

%Simple_Joystick_SIM
const_joy = [0 0 0 0 0 0]'; %[Y, X ,Rise,Sink,Yaw,Pitch]
FT_list_test = 10*[0 0 0 0 10 -10 10 -10]';
test_pwm_list = [1500 1500 1500 1500 1500 1500 1500 1500]';

%flags are used to turn parts of the simulation on and off
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; 
do_torque_flag = 1; 
do_force_flag = 1; 

%% Simulation Parameters
%simulation duration
tspan = 30;

%timesteps for various simulation components
dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/30, dt_sim); %data saving timestep
dt_control = roundToSimTimestep(1/100, dt_sim); %controller timestep

%mission file and model
mission_file_name = "drive_in_square_validation_mission.txt"; 
model_select = "FB_Controller_SIM";
open_system(model_select);

%setup for bus objects (necessary to use structures in Simulink)
max_commands_in_mission = 64; 
run('setup_cmd_bus.m');
run('setup_FF_maneuvers_bus.m');
run('setup_state_bus.m');
run('setup_sensor_bus.m');

%set To-File block names
setToFileBlockNames(model_select, prj_path_list.user_data_path);
%enableToFileBlocks(model_select);
disableToFileBlocks(model_select);

%comment or uncomment the to-workspace blocks (for performance reasons)
enableToWorkspaceBlocks(model_select);
% disableToWorkspaceBlocks(model_select);

%import the mission text file as an array of cmd objects
mission_file_path = fullfile(prj_path_list.inits_path,mission_file_name);
mission = importMission(mission_file_path, max_commands_in_mission);

%% Simulation
%this function uses a ToFile block to save data if the simulation ends
%prematurely do to crash or user interrupt
% sim_mat_path = crashProofDataSaving(model_select, prj_path_list.user_data_path); 
% path_of_to_file_block = [char(model_select),'/Low-Level Controller','/To File']; %this must be correct
% set_param(path_of_to_file_block,'Filename',sim_mat_path);

%setup the sim
simIn = Simulink.SimulationInput(model_select);

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
plot_names = {"X", "cmd_status","Fb, Mb", "Eul_u", "idle_wp"};
plotAllOutputs(plots,results,plot_names);
% saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.Cib.Data,prj_path_list.temp_path,"test");
% saveOutputMat(results,prj_path_list.user_data_path,do_state_save_flag,do_gif_flag);