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

tspan = 10;
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim
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
do_drag_flag = 0;

%% Run Sim
%create the simIn object to pass in model parameters
ft_list = [0 0 0 0 0 0 0 0];
simIn = Simulink.SimulationInput("Dynamics");
simIn = simIn.setVariable('ft_list_test',ft_list);
results = sim(simIn);

gif_data = {results.Ri,results.Eul,ft_list};

%control mode
mode_id = 1;

%target state
R_target = [0; 0; 0;];
Eul_target = [0; 0; 0];
X_target = [R_target;Eul_target];
%% Run Post Processing
plotAllOutputs(results);
% saveAllOutputs(results,prj_path_list.user_data_path);
    

