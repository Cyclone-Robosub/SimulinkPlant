clc
close all

%% Run setup scripts
run('constants_FF.m')

%% Set Sim Parameters
name = "missionfile_FF_v0.xlsx";
mission_file = importMissionFile(name); %make sure mission file is in the search path
mission_file = numericMissionFile(mission_file); %convert to numeric array to be supported by Codegen
reltol = 1e-8;
abstol = 1e-8;

tspan = 20;
dt_data = 0.1;
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

simIn = Simulink.SimulationInput("Feedforward_Control");
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

%% Run Post Processing
plotAllOutputs(results);
