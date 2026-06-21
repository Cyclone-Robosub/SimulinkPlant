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
else
    if(~unreal_EXE_found)
        fprintf("Unreal Executable found, linking exe to UCS simulink models.\n")
        unreal_EXE_found = true;
        run('link_EXE_UCS.m')
    end
end

%% Parameters
%Always run constants_UCS first as values in it may be overridden by model
%specific constants.
run('constants_UCS.m')

%Simulation Duration
tspan = 6.1;

%model selection
model_select = "CameraCalibration_UCS";

%setup the sim
simIn = Simulink.SimulationInput(model_select);

%run the sim
results = sim(simIn);

%% Post Processing

fprintf("Saving Images...\n");
fprintf("Saved Images: 0/45");
for i = 1:45
    imageNameLeft = fullfile(saved_images_path,"CalibrationImages/LeftCamera/CalibrationImage" + i + ".jpg");
    imageNameRight = fullfile(saved_images_path,"CalibrationImages/RightCamera/CalibrationImage" + i + ".jpg");
    
    imwrite(results.leftCameraFeed(:,:,:,i+6), imageNameLeft);
    imwrite(results.rightCameraFeed(:,:,:,i+6), imageNameRight);
    
    fprintf(repmat('\b', 1, strlength(int2str(i-1)) + 3));
    fprintf(i + "/45");
end

fprintf("\nFinished saving images...\n");
fprintf("Opening calibtrator app...\n");
todayDate = datetime();
saved_left_images_path = fullfile(saved_images_path, "CalibrationImages/LeftCamera");
saved_right_images_path = fullfile(saved_images_path, "CalibrationImages/RightCamera");
save_file_path = fullfile(UCS_lookup_path, "stereoParams.mat");
stereoCameraCalibrator(saved_left_images_path, saved_right_images_path, squareSize, "centimeters");
input("Once Camera Calibrator App has loaded click calibrate...\nThen click export parameters...\nType Enter once finished exporting");
save(save_file_path,"stereoParams");