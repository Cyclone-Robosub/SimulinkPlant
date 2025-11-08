%{
This script is intended to generate an animation of Manny simulation
results for debugging purposes. The objective is to input a file path
filled with .mat files of data, then let this script automatically create a
gif for each test case.

Changelog:
Created on Nov 6, 2025 -KJH
%}

%% Setup
data_file_path = '/home/kjhaydon/Github/SimulinkPlant/src/temp';

%the higher this frame rate is the longer it will take to render
frame_rate = 30;

%% Script
data_file_type = '*.mat';
path = fullfile(data_file_path,data_file_type);
data_files = dir(path);

data = load(fullfile(data_file_path,data_files(1).name),'gif_data');
data = data.gif_data;
R = squeeze(data(1)); %extract position
R = R{1}.Data;
Eul = squeeze(data(2)); %eulers
Eul = Eul{1}.Data;
ft_list = squeeze(data(3));
ft_list = ft_list{1};



%TODO:
% add function to automatically save selected results
% regenerate data at higher framerate
% add ability to extract data at a specific framerate
% add thrust vector plotting
% add animations
% save animations to file
