%{
This script configures various settings and file paths to make sure all the
features of this codebase work correctly.

See the "SimulinkPlant User/Editor Guide" on Notion for a detailed tutorial
on how to use this codebase.
%}
clc
close all
clear all

%% 1 - Add files to the search path.
root_path = pwd; %project root

%get the current project
try
    prj = currentProject;
catch
    error("You are running the startup script before you opened the project. That won't work.")
end

src_path = fullfile(root_path,'src');
temp_path = fullfile(src_path,'temp');
inits_path = fullfile(src_path,'inits');
thruster_lookup_path = fullfile(src_path,'utils','T200 Thruster Lookups');
user_data_path = temp_path;
startup_path = fullfile(root_path,'project_startup');
closedown_path = fullfile(root_path,'project_closedown');
codegen_path = fullfile(root_path,'codegen','slprj_and_caches');
%add all necessary paths to the project path
addpath(root_path);
addpath(startup_path);
addpath(closedown_path);

%add src and all subfolders recursively
src_sub_folders = string(genpath(src_path));
src_sub_folders = split(src_sub_folders,pathsep);
%remove empty entries created by split command
src_sub_folders(src_sub_folders=="") = [];
%convert to cell array for addpath
src_sub_folders = cellstr(src_sub_folders);
%add them all to the path
addpath(src_sub_folders{:});

%% 2 - Check for and/or create missing folders.

%make sure each path exists and is a directory
if(~isfolder(root_path))
    error("I have no idea how you managed to trigger this error. Did you change the name of the SimulinkPlant folder?");
end
if(~isfolder(src_path))
    error("You are missing the src folder. Not sure how you managed that. You may need to re-clone the repo.")
end
if(~isfolder(temp_path))
    fprintf("Folder for temporary files is missing. Creating it now.\n")
    mkdir(temp_path);
end
if(~isfolder(codegen_path))
    fprintf("Folder for automatically generated files is missing. Creating it now.\n")
    mkdir(codegen_path);
end
if(~isfolder(inits_path))
    error("You are missing the inits folder. Not sure how you managed that. You may need to re-clone the repo.")
end
if(~isfolder(thruster_lookup_path))
    error("You are missing the thruster lookup folder. It may be in the wrong place or deleted. You may need to re-clone the repo.")
end
if(~isfolder(startup_path))
    error("You are missing the folder containing this script. I have no idea how you got this error.")
end
if(~isfolder(closedown_path))
    error("Missing closedown folder. Not sure how you managed that. You may need to reclone the repo.")
end

%create a variable storing all these file paths for other methods to access
prj_path_list.root_path = root_path;
prj_path_list.src_path = src_path;
prj_path_list.temp_path = temp_path;
prj_path_list.inits_path = inits_path;
prj_path_list.thruster_lookup_path = thruster_lookup_path;
prj_path_list.user_data_path = user_data_path;
save(fullfile(startup_path,"prj_path_list.mat"),"prj_path_list",'-mat');

cd(inits_path)
fprintf("Filepaths configured successfully. Moving you to inits.\n");

%% 3 - Configures file path for automatically generated temporary files.
Simulink.fileGenControl('set',...
    'CacheFolder',codegen_path,...
    'CodeGenFolder',codegen_path);

fprintf("Cache and CodeGen file paths are setup.\n");

%% 4 - Clear the temporary folder for a clean workspace if there is anything in it.
%suppress warnings for removed temp files
warningState = warning('off','all');
clearTemp();
warning(warningState);
fprintf("Temporary files have been cleared out.\n");

fprintf("Setup complete.\n\n")

