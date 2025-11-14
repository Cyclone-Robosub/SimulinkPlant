%{
Does the same thing as Manny gif tool but plots 10 robots at once.
%}

%% Setup
tic
data_folders_path = prj_paths_list.user_data_path;

%toggles
draw_manny_body = 1;
draw_thrust_vectors = 0; %not yet written
draw_Ri = 0; %not yet written
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
data.R = [];
data.Eul = [];
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
        
        %save data to one big structure
        
        data.R = [[data.R],[Ri_full(:,2:4)]];
        data.Eul = [[data.Eul],[Eul_full(:,2:4)]];
    end
    
end
colors = orderedcolors("glow12");
%set up figure
f = figure('Visible','off');
dt = t(2)-t(1);
ax = axes('Parent',f);
axis(ax,[-8 8 -8 8 -8 8])

axis(ax,'manual')
view(ax,3)

gif_path = fullfile(data_file_path,strcat(folder_name_k,".gif"));

R = data.R;
Eul = data.Eul;
frame_max = 1200;
starting_zoom = 8;
ending_zoom = 2;
zoom_lvl = linspace(starting_zoom,ending_zoom,length(t));
R = R(1:frame_max,:); %short arrays for testing
Eul = Eul(1:frame_max,:);
t = t(1:frame_max);

for j = 1:length(t)
    tnow = toc;
    clc
    fprintf("Rendering frame %d out of %d. Time elapsed %f sec.",j,frame_max,tnow)

    Rj = R(j,:);
    Eulj = R(j,:);
    cla(f) %clear the figure
    set(gca,'Zdir','reverse')
    set(gca,'Ydir','reverse')
    axis(ax,[-zoom_lvl(j) zoom_lvl(j) -zoom_lvl(j) zoom_lvl(j) -zoom_lvl(j) zoom_lvl(j)]);
    for k = 1:length(folderNames)
        Rk = Rj(3*k-2:3*k)';
        Eulk = Eulj(3*k-2:3*k);       
        C = eul2rotm([Eulk(3) Eulk(2) Eulk(1)]);
        colork = colors(k,:);
        kdrawManny(Rk,C,'Figure',f,'FaceColor',colork);
        kdrawAxis('Figure',f,'Length',10);
        title('First PID Test')
        
    end
    frame = getframe(f);
    [A,map] = rgb2ind(frame2im(frame),256);
    if j == 1
        imwrite(A,map,gif_path,'gif','LoopCount',inf,'DelayTime',dt);
    else
        imwrite(A,map,gif_path,'gif','WriteMode','append','DelayTime',dt);
    end

end

toc