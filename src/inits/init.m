%{
This is the master initialization file for the Cyclone Robosub Simulink.

This file can setup, run, plot, and save data from any simulation variant
included in the system that does not require communication with systems
external to MATLAB such as the joystick website, the robot, or Gazebo. 

If you need to make significant modifcations to this file, create a copy
instead and give it an extension such as init_variant and place it in init
archive.
%}

%% Housekeeping and Path Management
clc
close all
clear results

if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

stashASVFiles(); %move pesky .asv files out of the way
clearTemp();
%% Parameters
run('constants.m')

%% Initial Conditions
%initial intertial position
xi_0 = 10;
yi_0 = 10;
zi_0 = .5;
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
%list of thruster forces
test_ft_list = zeros(8,1); %used by Dynamics

%% Simulation Parameters
%simulation time step
dt_sim = 0.0001;

%simulation duration
tspan = 1;

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
do_Fb_correction = 0; 

%mission file
mission_file_path = fullfile(prj_path_list.inits_path,"mission_file.txt");
mission_file = importMissionCSV(mission_file_path);

%% Simulation
%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput("PID_Tuning_Ideal_Feedback_Control");
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

%% Post Processing
do_gif_flag = 0; %to create the gif
do_state_save_flag = 0;
%saveAllOutputs(results,prj_path_list.temp_path,do_state_save_flag,do_gif_flag);

plotAllOutputs(results);