%{
This is the initialization file for joystick controller mode.

Included here are many of the same lines from the master control mode but
we instead are relying on 
%}

%% Housekeeping and Path Management
clc
close all

if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

%stashASVFiles(); %move pesky .asv files out of the way



%% Parameters
run('constants.m')


%% Simulation Parameters

%simulation duration
tspan = 60;

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


%enable ROS publishing and subscribing
enable_publish_flag = 1;
enable_subscribe_flag = 0;

%% Simulation
%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput("Joystick_Controller");
results = sim(simIn);

%% Save Results
%Code to save results here
saveResultMat(results,prj_path_list.user_data_path);
