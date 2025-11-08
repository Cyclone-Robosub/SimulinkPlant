%{
This script is intended to generate an animation of Manny simulation
results for debugging purposes. The objective is to input a file path
filled with .mat files of data, then let this script automatically create a
gif for each test case.

Changelog:
Created on Nov 6, 2025 -KJH
%}

%% Setup
data_folders_path = '/home/kjhaydon/Github/SimulinkPlant/src/temp';

%specifiy the names of the specific data folders in the source directory.
%leave this empty to plot all folders.
folders_to_plot = "";

%find all the folders at path
data_folders = dir(data_folders_path); %find all files at the path
data_folders = data_folders([data_folders.isdir]); % keep only folders
data_folders = data_folders(~ismember({data_folders.name},{'.','..','slprj'}));  %remove non-data folders
folderNames = {data_folders.name}; %get list of names

frame_rate = 30;

%% Script

for k = 1:length(folderNames)
    name_structk = folderNames(k);
    folder_name_k = name_structk{1};
    data_file_path = fullfile(data_folders_path,name_k);
    data_files = dir(fullfile(data_file_path,"*.txt"));
    data_file

end


%TODO:
% add function to automatically save selected results
% regenerate data at higher framerate
% add ability to extract data at a specific framerate
% add thrust vector plotting
% add animations
% save animations to file
