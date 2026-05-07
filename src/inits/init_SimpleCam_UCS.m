%{
Init file for simple camera view.
%}

%% Housekeeping and Path Management
clc
close all
clear results
%clear all %slow, comment this out if you don't need it

%refreshes the file path in case clear all was called
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

%if executable doesn't exist exits program
if(~isfile(unreal_executable_path))
    fprintf("Unreal Executable not found. Please add files to DROP UCS PACKAGED...\nMake sure to take take all files out of the folder that says your OS (ie. Windows, Linux) and drop them in the folder.\n")
    unreal_EXE_found = false;
    return;
else
    if(~unreal_EXE_found)
        fprintf("Unreal Executable found, linking exe to UCS simulink models.\n")
        unreal_EXE_found = true;
        run('link_EXE_UCS.m')
    end
end


%% Parameters
%run('constants.m') %load all necessary constants into the workspace
run('constants_UCS.m')
run('constants_SimpleCam_UCS.m')

%% Test Conditions
% Not all test conditions are needed for every model

%model selection
model_select = "SimpleCam_UCS";

%setup the sim
simIn = Simulink.SimulationInput(model_select);

%run the sim
results = sim(simIn);