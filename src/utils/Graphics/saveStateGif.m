function saveStateGif(t,Ri,Cib,filepath,name,varargin)
%{
This function creates an animated gif of Manny and saves it to a file.
Using default settings, the gif will need about 1 second of render time per
one second of simulated time. Adjusting the settings from default can
reduce or improve this time, the most influential factor being the 
framerate and dynamic camera.

INPUTS
t - [Nx1] time vector (s)
Ri - [Nx3] inertial position vector (m)
Cib - [3x3xN] vector of rotation matrices from the body to inertial frame
filepath - [string] path where the output media will be saved
name - [string] name assigned to the output media

Code by Kory Haydon
11/23/25
%}

%parse optional kwargs
p = inputParser;

%optional inputs
addParameter(p,'Margin',1) %sets spacing around the center of Manny
addParameter(p,'View',3) %controls the direction of the observer
addParameter(p,'DynamicCameraMotion',1) %controls whether the camera tracks Manny
addParameter(p,'MakeGif',1)
addParameter(p,'MakeVideo',0)
addParameter(p,'OpenFolder',1)

%parse
parse(p,varargin{:});

%name the variables more sensible things
Margin = p.Results.Margin;
View = p.Results.View;
DynamicCameraMotion = p.Results.DynamicCameraMotion;
MakeGif = p.Results.MakeGif;
MakeVideo = p.Results.MakeVideo;
OpenFolder = p.Results.OpenFolder;

%start a timer
tic

%enforce Ri [3xN] for later manipulation
Ri = enforceTallSkinny(Ri)';

fprintf("Creating media.\n");

%precompute axis bounds
if(DynamicCameraMotion)
    bound_matrix = [-Margin+Ri(1,:);Margin+Ri(1,:);-Margin+Ri(2,:);Margin+Ri(2,:);...
        -Margin+Ri(3,:);Margin+Ri(3,:)];
end

% Make sure file paths are available to this function
if(~exist("project_path_list","var"))
    project_path_list = getProjectPaths();
end

%set up the figure
f = figure('Visible','off','Position',[400 2400 1200 800]);
ax = axes('Parent',f);
axis(ax,'manual')
axis(ax,Margin.*[-1 1 -1 1 -1 1])
view(ax,View)
hold on
xlabel("x")
ylabel("y")
zlabel("z")
title(name)
set(gca,'Zdir','reverse')
set(gca,'Ydir','reverse')

%load the patch data for Manny from where it is stored in the file system
%will be already on path if using project structure correctly
p_struct = load("manny_patch.mat","p");
p = p_struct.p;

% Set up lighting
light('Position',[1 1 1],'Style','infinite');

%identify timestep in data
dt = t(2)-t(1);

%set up hgtransform for the patch data for quicker math
tObj = hgtransform('Parent',ax);
p.Parent = tObj;

%TODO - Make frameskip a keyword argument
frameskip = 1;
frame_index = 1;

%frames
nFrames = round(length(t)/frameskip);
frameArray = cell(1,nFrames);  % store frames

%Start printout percentage
percent_text = fprintf("Media is 0.00%% Complete");

for k = 1:frameskip:length(t)
    %get rotation and position at timestep k
    Cibk = Cib(:,:,k);
    Rik = Ri(:,k);

    %build transform matrix
    T = eye(4);
    T(1:3,1:3) = Cibk;
    T(1:3,4) = Rik;
    tObj.Matrix = T;

    %draw plot and save the frame
    drawnow limitrate;
    frameArray{frame_index} = getframe(f);
    frame_index = frame_index + 1;
    
    %update axis to track Manny's position
    if(DynamicCameraMotion)
        axis(ax,bound_matrix(:,k))
    end

    %print progress to user every 10 frames
    if(mod(frame_index,10)==0)
        percent_complete = frame_index/nFrames*100;

        fprintf(repmat('\b',1,percent_text));
        percent_text = fprintf("Media is %.2f%% Complete\n",percent_complete);
    end
end

close(f);


if(MakeVideo)
    video_path = fullfile(filepath,name + ".avi");
    v = VideoWriter(video_path,'Motion JPEG AVI');
    v.FrameRate = 1/dt;
    open(v);

    for k = 1:nFrames
        writeVideo(v,frameArray{k});
    end

    close(v);
end


if(MakeGif)
    %define the path for the gif
    gif_path = fullfile(filepath,name+".gif");
    for k = 1:nFrames
        %convert each frame to grayscale for speed
        grayFrame = rgb2gray(frameArray{k}.cdata);
        %convert each frame to a 256x256 indexed image "A" with colormap "map"
        [A,map] = gray2ind(grayFrame,256);
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
if(OpenFolder)
    try
        winopen(filepath);
    catch
        fprintf("Failed to open the media folder.\nThis feature only works on windows right now ):")
    end
end