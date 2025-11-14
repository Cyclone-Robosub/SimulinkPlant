%% Housekeeping
clc %clears command line
close all %closes figures
%clear all %deletes workspace, optional

prj_paths_list = getProjectPaths(); %load the file paths identified on prj start
stashASVFiles(); %move pesky .asv files out of the way

%% Run setup scripts
run('constants.m')

%% Set Sim Parameters
dt_sim = 0.0001;

tspan = 120;
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim
dt_control = 0.01;
%% Initial Conditions
%initial intertial position
xi_0 = 10;
yi_0 = 10;
zi_0 = 10;
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
ui_0 = 0;
vi_0 = 0;
wi_0 = 0;
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = -pi/6;
theta_0 = pi/6;
psi_0 = pi/2;
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

%flags
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; %used to freeze time at the given initial conditions without having to change plot functions
do_torque_flag = 1; %prevent vehicle from rotating for PID tuning
do_force_flag = 1; %prevent the vehicle from translating for PID tuning
do_Fb_correction = 0; 

%mission file
mission_file_path = fullfile(prj_paths.inits_path,"missionfile_FF_v2.xlsx");
mission_file_struct = importMissionFile(mission_file_path);
mission_file = numericMissionFile(mission_file_struct);

%control mode
mode_id = 2;

%target state
R_target = [0; 0; 0;];
Eul_target = [0; 0; 0];
X_target = [R_target;Eul_target];

%% Run Sim
%create the simIn object to pass in model parameters

simIn = Simulink.SimulationInput("Ideal_Feedback_Control");
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);
    
%% Run Post Processing
close all
%plotAllOutputs(results); %uncomment this to plot every signal
plots = {'Ri','Eul','FT_list','Fb_cmd_PID','Mb_cmd_PID','dRi'};
plotAllOutputs(results,plots); %use this to plot only specific variables

% To save data to the a folder
%path = 'C:\GitHub\Cyclone Robosub\SimulinkPlant\src\temp';
%saveAllOutputs(results,path);
    

