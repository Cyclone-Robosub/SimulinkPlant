clc
close all

%% Run setup scripts

%% Set Sim Parameters
name = "missionfile_FF_v0.xlsx";
mission_file = table2struct(importMissionFile(name))'; %make sure mission file is in the search path
parseMissionFile(mission_file,0,0,-1);
reltol = 1e-8;
abstol = 1e-8;

tspan = 10;
dt_data = 0.1;
dt_control = 0.01;

%% Run Sim

%% Run Post Processing

