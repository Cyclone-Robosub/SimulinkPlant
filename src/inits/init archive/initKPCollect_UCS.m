%{
Init File for generating Keypoints. Run this file to generate keypoints
around a prop. Currently only prop supported is a default gate. 
Todo: 
    - more documentation
    - roll adjustments (random?)
    - 
%}

%% Housekeeping and Path Management
clc
close all
%clear all %slow, comment this out if you don't need it

%refreshes the file path in case clear all was called
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

%if executable doesn't exist exits program
unreal_executable_path = fullfile(unreal_build_path, "EllingtonPoolSim.exe");
if(~isfile(unreal_executable_path))
    fprintf("Unreal Executable not found. Please add files to DROP UCS PACKAGED...\nMake sure to take take the files out of the folder that says your OS (ie. Windows, Linux)\nOnce files are  added run link_EXE_UCS.m script")
    return;
end

%set_param('KP_Collect_UCS/Simulation 3D Scene Configuration', 'ProjectName', unreal_executable_path);


%% Parameters
%run('constants.m') %load all necessary constants into the workspace
run('constants_UCS.m')
run('constants_KP.m')

%% Test Conditions
% Not all test conditions are needed for every model

%model selection
model_select = "KP_Collect_UCS";

%setup the sim
simIn = Simulink.SimulationInput(model_select);

%run the sim
results = sim(simIn);

%% Post Processing
run('saveKeyPointFiles.m')
