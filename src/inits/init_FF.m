clc
close all
clear all
%% Run setup scripts
run('constants.m')

%% Set Sim Parameters
rel_tol = 1e-9;
abs_tol = 1e-9;

tspan =30;
dt_data = 1/30;
dt_control = 0.01;
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

%flags
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 0;

%mission file
mission_file_path = '/home/kjhaydon/Github/SimulinkPlant/src/inits/mission file archive/missionfile_FF_v1.xlsx';
mission_file_struct = importMissionFile(mission_file_path);
mission_file = numericMissionFile(mission_file_struct);
%% Run Sim
%create the simIn object to pass in model parameters

simIn = Simulink.SimulationInput("Feedforward_Control");
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

gif_data = {results.Ri,results.Eul,results.FT_list};
    
%% Run Post Processing
%plotAllOutputs(results); %uncomment this to plot every signal
plots = {'Ri'};
plotAllOutputs(results,plots); %use this to plot only specific variables

% To save data to the a folder
% path = '/home/kjhaydon/Github/SimulinkPlant/src/temp';
% saveAllOutputs(results,path);
    

