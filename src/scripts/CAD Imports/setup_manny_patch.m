%{
Testing script to attempt to render vehicle motion much more rapidly.
Meant to be a direct upgrade and replacement to kdraw.
%}
close all
%% Read in the Rotation Matrix and Position Vector
tic
Cib_data = readmatrix('2025-11-22 18-58-43\Cib.txt');
Cib_flat = Cib_data(:,2:end)';
[~,n] = size(Cib_flat);
Cib = reshape(Cib_flat,3,3,n);

Ri_data = readmatrix('2025-11-22 18-58-43\Ri.txt');
t = Ri_data(:,1);
Ri = Ri_data(:,2:end);
t1 = toc;
fprintf("Time to read in data: %d\n",t1);
%% Setup Model and Figure

%identify sensible data bounds based on how far the robot moves
lower_bound = floor(min([min(Ri(:,1)),min(Ri(:,2)),min(Ri(:,3))]));
upper_bound = ceil(max([max(Ri(:,1)),max(Ri(:,2)),max(Ri(:,3))]));

f = figure('Visible','off','Position',[400 2400 1200 800]);ax = axes('Parent',f);
axis(ax,[lower_bound upper_bound lower_bound upper_bound lower_bound upper_bound])
axis(ax,'manual')
view(ax,3)
hold on
xlabel("x")
ylabel("y")
zlabel("z")
title("Test")

C_from_cad = [0 1 0;1 0 0;0 0 -1];
model = stlread('C:\Github\Cyclone Robosub\SimulinkPlant\drafts\Simplified Model - Simplified Manny - no holes.stl');
V = model.Points;
scale_factor = 2.54/100; %convert in to m
model_offset = mean(V,1) + [0 0 3];
V = scale_factor.*(V - model_offset);
F = model.ConnectivityList;

%reduce the number of triangles
[F,V] = reducepatch(F,V,.1);

V = (C_from_cad*V')';

p = patch('Parent',ax,'Faces',F,'Vertices',V,'FaceColor',...
    [0.8 0.8 0.8],'LineStyle','none','FaceAlpha',1);

light('Position',[1 1 1],'Style','infinite');

p.FaceLighting = 'flat';
p.EdgeLighting = 'none';
p.BackFaceLighting = 'unlit';

set(gca,'Zdir','reverse')
set(gca,'Ydir','reverse')
t2 = toc;
fprintf("Time to set up model and figure: %d\n",t2-t1);

%% Set Up Animation

dt = t(2)-t(1);

%precompute the movement of the vertices
Vt = pagemtimes(Cib,permute(V,[2 1 3])); %reshape V and rotate for each frame
Vt = permute(Vt,[2 1 3]); %reshape back into Mx3xN
Vt = Vt + reshape(Ri,1,3,[]); %shift by Ri



t3 = toc;
fprintf("Time to calculate Vt: %d\n",t3-t2);

%% Get Frames
tObj = hgtransform('Parent',ax);
p.Parent = tObj;

frameskip = 1;
frame_index = 1;

%frames
nFrames = round(length(t)/frameskip);
frameArray = cell(1,nFrames);  % store frames

for k = 1:frameskip:length(t)
    Cibk = Cib(:,:,k);
    Rik = Ri(k,:);
    T = eye(4);
    T(1:3,1:3) = Cibk;
    T(1:3,4) = Rik(:);
    tObj.Matrix = T;
    drawnow limitrate;
    frameArray{frame_index} = getframe(f);
    frame_index = frame_index + 1;
end

%close(f);
t4 = toc;
fprintf("Time to capture frames: %d\n",t4-t3);

%% Save to Video or Gif

video_flag = 0;
gif_flag = 1;

if(video_flag)
    video_path = 'C:\Github\Cyclone Robosub\SimulinkPlant\drafts\test.avi';
    v = VideoWriter(video_path,'Motion JPEG AVI');
    v.FrameRate = 1/dt;
    open(v);
    
    for k = 1:nFrames
        writeVideo(v,frameArray{k});
    end
    
    close(v);
end


if(gif_flag)

    gif_path = 'C:\Github\Cyclone Robosub\SimulinkPlant\drafts\test.gif';
    for k = 1:nFrames
        grayFrame = rgb2gray(frameArray{k}.cdata);
        [A,map] = gray2ind(grayFrame,256);
        if k == 1
            imwrite(A,map,gif_path,'gif','LoopCount',inf,'DelayTime',frameskip*dt);
        else
            imwrite(A,map,gif_path,'gif','WriteMode','append','DelayTime',frameskip*dt);
        end
    end

end
t5 = toc;
fprintf("Time to save as gif: %d\n",t5-t4);

fprintf("Total Time Elapsed: %d\n",t5);

fprintf("Rendering Rate: %d rendering seconds per video second.\n",t5/(t(end)-t(1)));
