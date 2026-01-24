%{
Init designed to run FF_Jan24_Pool_Test.

Objectives:
1. Run short mission files for individual FeedForward maneuvers.
2. Log data.
%}

%% Housekeeping and Path Management
clc
close all

if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

stashASVFiles(); %move pesky .asv files out of the way



%% Parameters
run('constants.m')

%% Initial Conditions
% Unneeded as FF_Jan24_Pool_Test has no plant.

%% Test Conditions
%list of mission files here

%% Simulation Parameters

%simulation duration
tspan = 10;

%simulation time step
dt_sim = 0.01; %only needs to run at 100Hz because no dynamics is done

%data saving rate
dt_data_target = 0.01; %we want to save data as rapidly as it is generated here
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim

%controller update rate
dt_control = 0.01;

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

%mode overwrite (not used here because we have mission files)
mode_overwrite = 0;
state_overwrite = zeros(6,1);

%mission file
 mission_file_name = "forward1.txt";
% mission_file_name = "backward2.txt";
% mission_file_name = "up3.txt";
% mission_file_name = "down4.txt";
% mission_file_name = "left5.txt";
% mission_file_name = "right6.txt";
% mission_file_name = "yawLeft7.txt"; %Too powerful for dry run(TPDR)
% mission_file_name = "yawRight8.txt"; %TPDR
% mission_file_name = "pitchUp9.txt"; %TPDR
% mission_file_name = "pitchDown10.txt"; %TPDR
% mission_file_name = "rollLeft11.txt"; %TPDR
% mission_file_name = "rollRight12.txt"; %TPDR
% mission_file_name = "roll_pitch_yaw_FF_demo.txt";

mission_file_path = fullfile(prj_path_list.inits_path, "mission file archive","Jan_24_Pool_Test",mission_file_name);
mission_file = importMissionCSV(mission_file_path);

%enable ROS publishing and subscribing
enable_publish_flag = 1;
enable_subscribe_flag = 0;

%% Simulation
%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput("FF_Jan24_Pool_Test");
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

%% Post Processing
plots = {'pwm_cmd','cmd','FF_maneuver_data','FT_cmd_list','mode_flags'};
plotAllOutputs(results, plots);

%% Save Results
%Code to save results here
saveAllOutputs(results,prj_path_list.user_data_path,0,0);