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

<<<<<<< HEAD
if(~exist("plots_defined_flag","var"))
    run("setup_plots.m");
end

prj_path_list.sim_data_path = prepareOutputFolder(prj_path_list);


=======
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090
%% Parameters
run('constants.m') %load all necessary constants into the workspace

%% Initial Conditions
%initial intertial position
<<<<<<< HEAD
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
=======
xi_0 = 0; yi_0 = 0; zi_0 = 0;
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
ui_0 = 0; vi_0 = 0; wi_0 = 0;
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = 0; theta_0 = 0; psi_0 = 0;
Eul_0 = [phi_0; theta_0; psi_0]; %[roll, pitch, yaw]
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090

%other attitude representations
Cib_0 = eulToRotm(Eul_0);
q_0 = eulToQuat(Eul_0); %[vector; scalar]

%initial angular velocity
<<<<<<< HEAD
wx_0 = 0;
wy_0 = 0;
wz_0 = 0;
wb_0 = [wx_0; wy_0; wz_0];
=======
wbx_0 = 0; wby_0 = 0; wbz_0 = 0;
wb_0 = [wbx_0; wby_0; wbz_0];
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090

%pack initial state
X0 = [Ri_0;q_0;dRi_0;wb_0];

%% Test Conditions
<<<<<<< HEAD
=======
% Not all test conditions are needed for every model

%battery voltage
const_voltage = 15;
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090

%test_ft_list = [0 0 0 0 10 10 10 10];
%test_pwm_list = [1500 1500 1500 1500 1800 1800 1200 1200];
%assumes mission_file.txt is in the src/inits/ folder
mission_file_name = "mission_file.txt"; 

%name of the model to be ran
sim_select = "Integrated_Joystick_HIL.slx";
%battery voltage if constant
const_voltage = 14;

%joystick input if constant
const_joy = [0 0 0 0 0 0]'; %[Y, X ,Rise,Sink,Yaw,Pitch]
<<<<<<< HEAD

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
=======
FT_list_test = 10*[0 0 0 0 10 -10 10 -10]';
test_pwm_list = [1500 1500 1500 1500 1500 1500 1500 1500]';
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090

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

<<<<<<< HEAD
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
%% Data Saving
save_plots_flag = false;
save_gif_flag = false;
save_results_flag = false; %saves after a run
save_HIL_results_flag = false; %saves directly from simulink during a run
%% Simulation
%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput(sim_select);
simIn = simIn.setVariable('mission_file',mission_file);
=======
%% Simulation Parameters
%simulation duration
tspan = 30;

%timesteps for various simulation components
dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/30, dt_sim); %data saving timestep
dt_control = roundToSimTimestep(1/100, dt_sim); %controller timestep

%mission file and model
mission_file_name = "FF_prequal_mission.txt"; 
model_select = "FB_Controller_SIM";

%setup for bus objects (necessary to use structures in Simulink)
max_commands_in_mission = 64; 
run('setup_cmd_bus.m');

%setup bus for FF maneuvers
run('setup_FF_maneuvers_bus.m');

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
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090
results = sim(simIn);

%% Post Processing
<<<<<<< HEAD

%{
If you add more to-workspace blocks, set up the plots in setup_plots, then
clear the workspace and rerun the init.
>>open setup_plots.m
>>clear all
>>setup_plots
>>init
%}

target_plots = {};
plotAllOutputs(results,plots,target_plots, prj_path_list, save_plots_flag);


%saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.Cib.Data,prj_path_list.temp_path,"test");
=======
run('setup_plots.m')

% Enter the names of all the plots as a comma separated cell array
% Refer to setup_plots.m to see the valid plot names
plot_names = {"X", "cmd_status","Fb, Mb", "Eul_u", "idle_wp"};
plotAllOutputs(plots,results,plot_names);
saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.Cib.Data,prj_path_list.temp_path,"test");
% saveOutputMat(results,prj_path_list.user_data_path,do_state_save_flag,do_gif_flag);
>>>>>>> fdbeab81971ce749fa28e167eaac6aa7cea5f090
