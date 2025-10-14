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

%% Run Sim
%create the simIn object to pass in model parameters
simIn = Simulink.SimulationInput("Feedforward_Control");
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

%% Run Post Processing
%plotAllOutputs(results);
