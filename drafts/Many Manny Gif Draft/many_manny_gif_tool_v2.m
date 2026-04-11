%{
Plots many Manny's from a folder full of results.mat files.
%}

%path where all the .mat files are saved
data_path = "C:\Github\Cyclone Robosub\SimulinkPlant\drafts\Many Manny Gif Draft";

%load up files
files = dir(fullfile(data_path, '*.mat'));
file_list = {files.name}';
num_files = length(file_list);
%preallocate Ri and qib structures
Ri = repmat(struct('data', [],'time', []), num_files, 1);
qib = repmat(struct('data', [], 'time', []), num_files, 1);


%structure for Ri
for k = 1:length(file_list)
    results_k = load(fullfile(data_path, file_list{k}), 'results');
    Ri(k).data = squeeze(results_k.results.Ri.Data)';
    qib(k).data = squeeze(results_k.results.q.Data)';
    Ri(k).time = squeeze(results_k.results.Ri.Time);
    qib(k).time = Ri(k).time;
end

%calculate the dynamic boundaries of the frame based on the Manny farthest
%from the origin at each timestep
boundary_value = ones(size(Ri(1).time));
flattened_data = [Ri.data];
for k = 1:length(Ri(1).time)
    boundary_value(k) = max(abs(flattened_data(k,:))) + 2;
end
bound_matrix = boundary_value*[-1, 1, -1, 1, -1, 1];


% Make sure file paths are available to this function
if(~exist("project_path_list","var"))
    project_path_list = getProjectPaths();
end

%set up the figure
f = figure('Visible','off','Position',[400 2400 1200 800]);
ax = axes('Parent',f);
axis(ax,'manual')
axis(ax,max(boundary_value).*[-1 1 -1 1 -1 1])
view(ax,3)
hold on
xlabel("x")
ylabel("y")
zlabel("z")
title("Many Manny's Mooovin")
set(gca,'Zdir','reverse')
set(gca,'Ydir','reverse')

%load the patch data for Manny from where it is stored in the file system
%will be already on path if using project structure correctly
p_struct = load("manny_patch.mat","p");
p = p_struct.p;

%create a patch for each Manny
N_Mannys = num_files;
p_list = gobjects(N_Mannys, 1);

%setup color gradiant
colors = hsv(N_Mannys);

for k = 1:N_Mannys
    %create a bunch of copies of the Manny Patch for each Manny
    p_list(k) = copyobj(p, gca);
end

%create an hgtransform for each manny
transform_list = gobjects(N_Mannys, 1);
for k = 1:N_Mannys
    transform_list(k) = hgtransform('Parent',ax);
    p_list(k).Parent = transform_list(k);
    p_list(k).FaceColor = colors(k,:);
end

% Set up lighting
light('Position',[1 1 1],'Style','infinite');

%identify timestep in data (assume all have the same t)
t = Ri.time;
dt = t(2)-t(1);

%TODO - Make frameskip a keyword argument
frameskip = 1;
frame_index = 1;

%frames
nFrames = round(length(t)/frameskip);
frameArray = cell(1,nFrames);  % store frames

%Start printout percentage
percent_text = fprintf("Media is 0.00%% Complete");
tic
for k = 1:frameskip:length(t) %for each frame
    for j = 1:N_Mannys %for each Manny
        %get this Manny's rotation and position
        Ri_kj = Ri(j).data(k,:);
        Ri_kj = Ri_kj(:);
        qib_kj = qib(j).data(k,:);
        Cib_kj = quatToRotm(qib_kj);

        %build the transform matrix
        T = eye(4);
        T(1:3, 1:3) = Cib_kj;
        T(1:3,4) = Ri_kj;
        transform_list(j).Matrix = T;
    end

    %draw plot and save the frame
    drawnow limitrate;
    frameArray{frame_index} = getframe(f);
    frame_index = frame_index + 1;
    
    %update axis to track Manny's position
    if(1)
        axis(ax,bound_matrix(k,:))
    end

    %print progress to user every 10 frames
    if(mod(frame_index,10)==0)
        percent_complete = frame_index/nFrames*100;

        fprintf(repmat('\b',1,percent_text));
        percent_text = fprintf("Media is %.2f%% Complete\n",percent_complete);
    end

end

close(f);

if(1)
    %define the path for the gif
    gif_path = fullfile(data_path,"test"+".gif");
    for k = 1:780
        %convert each frame to grayscale for speed
        grayFrame = rgb2gray(frameArray{k}.cdata);
        %convert each frame to a 256x256 indexed image "A" with colormap "map"
        [A,map] = gray2ind(grayFrame,256);
        [A,map] = rgb2ind(frameArray{k}.cdata, 256, 'nodither');
        %append the image to the gif
        if k == 1
            imwrite(A,map,gif_path,'gif','LoopCount',inf,'DelayTime',frameskip*dt);
        else
            imwrite(A,map,gif_path,'gif','WriteMode','append','DelayTime',frameskip*dt);
        end
    end

end

%Overwrite prior text line with new one to avoid annoying scrolling
fprintf(repmat('\b',1,percent_text));
fprintf("Gif is 100.0%% Complete\n");
t1 = toc;
fprintf("Time elapsed: %.2f seconds.\n",t1)

%Open the file location of the gif if the user chooses
%%
if(1)
    try
        winopen(data_path);
    catch
        fprintf("Failed to open the media folder.\nThis feature only works on windows right now ):")
    end

end