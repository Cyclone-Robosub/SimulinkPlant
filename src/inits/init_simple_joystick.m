%{
Initializing script meant for simple joystick controller.

Objectives:
1. Start Joystick for 

%}

%% Housekeeping and Path Management
clc
close all

if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

stashASVFiles(); %move pesky .asv files out of the way
