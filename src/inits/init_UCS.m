%{
    Master init for _UCS models. Mostly a sample that is meant to be
    duplicated for other _UCS model inits.
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
if(~isfile(unreal_executable_path))
    fprintf("Unreal Executable not found. Please add files to DROP UCS PACKAGED...\nMake sure to take take all files out of the folder that says your OS (ie. Windows, Linux)\n and drop them in the folder.\n")
    unreal_EXE_found = false;
    return;
end

%simulation duration
tspan = 15;

%timesteps for various simulation components
dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/100, dt_sim); %data saving timestep
dt_control = roundToSimTimestep(1/100, dt_sim); %controller timestep
dt_dvl_drr = roundToSimTimestep(1/5, dt_sim);
dt_dvl_vr = roundToSimTimestep(1/20, dt_sim);
dt_imu = roundToSimTimestep(1/100, dt_sim);
dt_heartbeat = roundToSimTimestep(1/2, dt_sim);


%% Parameters
%Always run constants_UCS first as values in it may be overridden by model
%specific constants.
run('constants_UCS.m')
run('constants_Props_UCS.m')

%model selection
model_select = "Sample_Course_Controller_UCS";

%setup the sim
simIn = Simulink.SimulationInput(model_select);

%set the parameter `mission` containing all the cmd structures
%%
simIn = simIn.setVariable('stereo_params', stereo_params);

%run the sim
results = sim(simIn);
dM = results.disparityMap.signals.values(:,:,3);
dM = double(dM);
repM = results.reprojectionmatrix.signals.values(:,:,3);
pointCloud = reconstructScene(dM,repM);
pcshow(pointCloud)
%% Post Processing