clc
close all

%% Run setup scripts
run('constants_FF.m')

%% Set Sim Parameters
name = "missionfile_FF_v0.xlsx";
mission_file = importMissionFile(name); %make sure mission file is in the search path
mission_file = numericMissionFile(mission_file) %convert to numeric array to be supported by Codegen
reltol = 1e-8;
abstol = 1e-8;

tspan = 10;
dt_data = 0.1;
dt_control = 0.01;

%% Run Sim
results = sim('Feedforward_Control');

%% Run Post Processing

