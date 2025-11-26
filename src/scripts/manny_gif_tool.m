%{
This script is intended to generate an animation of Manny simulation
results for debugging purposes. The objective is to input a file path
filled with .mat files of data, then let this script automatically create a
gif for each test case.

The user can set the toggles in the Setup section to choose what is
plotted. 

Changelog:
Created on Nov 6, 2025 -KJH
%}

%% Setup
prj_paths_list = getProjectPaths(); %load the file paths identified on prj start
data_folders_path = prj_paths_list.user_data_path;

%toggles
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
%loop through all the folders
for k = 1:length(folderNames)

    %loop through all the files in the folder
    name_structk = folderNames(k);
    folder_name_k = name_structk{1};
    data_file_path = fullfile(data_folders_path,folder_name_k);
    data_files = dir(data_file_path); %find all files at the path
    data_files = data_files(~ismember({data_files.name},{'.','..','slprj'}));  %remove non-data folders
    data_file_names = {data_files.name}; %get list of names
    
    %make sure 'Eul.txt' and 'Ri.txt' exist
    if(sum(ismember(data_file_names,{'FT_list.txt'})) + sum(ismember(data_file_names,{'Eul.txt'})) + sum(ismember(data_file_names,{'Ri.txt'})) == 3)
        %do plotting
        FT_list_full = readmatrix(fullfile(data_file_path,"FT_list.txt"));
        Eul_full = readmatrix(fullfile(data_file_path,"Eul.txt"));
        Ri_full = readmatrix(fullfile(data_file_path,"Ri.txt"));

        %make sure all the time vectors have the same length, and throw an
        %error otherwise.
        l1 = length(FT_list_full(:,1));
        l2 = length(Eul_full(:,2));
        l3 = length(Ri_full(:,3));
        if(~((l1 == l2) &&  (l2 == l3)))
            error("Time axis in saved data must have the same length. Check sampling time in toworkspace blocks.");
        else
            t = FT_list_full(:,1); %extract the time
        end

        %set up figure
        f = figure('Visible','off');
        dt = t(2)-t(1);
        ax = axes('Parent',f);
        axis(ax,[-1 1 -1 1 -1 1])
        axis(ax,'manual')
        view(ax,3)
        
        gif_path = fullfile(data_file_path,strcat(folder_name_k,".gif"));
        for j = 1:length(t)
            cla(f) %clear the figure
            set(gca,'Zdir','reverse')
            set(gca,'Ydir','reverse')
            R = Ri_full(j,2:4);
            R = R';
            axis(ax,[-1+R(1) 1+R(1) -1+R(2) 1+R(2) -1+R(3) 1+R(3)]);
            Eul = Eul_full(j,2:4);
            C = eul2rotm([Eul(3) Eul(2) Eul(1)]);
            kdrawManny(R,C,'Figure',f);
            kdrawAxis('Figure',f);
            title(folder_name_k)
            frame = getframe(f);
            [A,map] = rgb2ind(frame2im(frame),256);
            if j == 1
                imwrite(A,map,gif_path,'gif','LoopCount',inf,'DelayTime',dt);
            else
                imwrite(A,map,gif_path,'gif','WriteMode','append','DelayTime',dt);
            end

        end
        close(f);
    end
    


end


%TODO:
% add function to automatically save selected results
% regenerate data at higher framerate
% add ability to extract data at a specific framerate
% add thrust vector plotting
% add animations
% save animations to file
