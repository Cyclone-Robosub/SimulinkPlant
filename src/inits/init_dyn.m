clc
close all
clear all

%% Run setup scripts
run('constants_dyn.m')

%% Set Sim Parameters
reltol = 1e-9;
abstol = 1e-9;

tspan = 5;
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
Vi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = 0;
theta_0 = 0;
psi_0 = 0;
Eul_0 = [phi_0; theta_0; psi_0];

Cbi_0 = eul2rotm([psi_0,theta_0,phi_0]);
Vb_0 = Cbi_0*Vi_0;


%initial angular velocity
p_0 = 0;
q_0 = 0;
r_0 = 0;
Wb_0 = [p_0; q_0; r_0];
%% Run Sim
%create the simIn object to pass in model parameters

ft_list_test = [0 0 0 0 0 0 0 1]';
simIn = Simulink.SimulationInput("Dynamics");
simIn = simIn.setVariable('ft_list_test',ft_list_test);
results = sim(simIn);

gif_data = {results.Ri,results.Eul,ft_list_test};

%% Run Post Processing
%plotAllOutputs(results);
path = '/home/kjhaydon/Github/SimulinkPlant/src/temp';
saveAllOutputs(results,path);

