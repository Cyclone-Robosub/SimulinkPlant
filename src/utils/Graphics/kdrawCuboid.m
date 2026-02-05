function kdrawCuboid(x, y, z, Cbo, center_position,varargin)
%{
Draw cuboid function used to render a cuboid in the currently active
plotting window given an x, y, and z dimension, the rotation matrix used to
map the x,y,z directions of the object to the body, and the position of
center of the cuboid.

Additional (optional) keyword arguments include:
FaceColor - color of faces used for patches and fills
FaceAlpha - transparancy of the face
LineWidth - width of lines
PatchLineColor - Color of patch and fill outlines, useful for debugging
CircleLineColor - Color of circular end outlines
CirclePoints - number of points used to render circles (100 by default)
Figure - which figure to plot on

Future improvements:
- decrease execution time (currently can run at ~37 Hz)
- vectorize inputs to allow multiple cuboid plots at once with the same optional input args. This
could be useful for plotting things like the thrusters. 

Credits:
- Code as part of the kdraw Toolbox by Kory Haydon for Cyclone Robosub
- Inspiration from https://github.com/emehiel/Matlab-Tools
- ChatGPT used for syntax help and some code snippets

%}
p = inputParser;
p.addRequired('x');
p.addRequired('y');
p.addRequired('z');
p.addRequired('Cbo');
p.addRequired('center_position');

p.addParameter('FaceColor','k');
p.addParameter('FaceAlpha',0.25);
p.addParameter('LineWidth',1);
p.addParameter('PatchLineColor','k');
p.addParameter('Figure',[]);
parse(p,'x','y','z','Cbo','center_position',varargin{:});

%define corners in body frame
v1 = center_position + Cbo*[x/2 y/2 z/2]';
v2 = center_position + Cbo*[-x/2 y/2 z/2]';
v3 = center_position + Cbo*[x/2 -y/2 z/2]';
v4 = center_position + Cbo*[x/2 y/2 -z/2]';
v5 = center_position + Cbo*[-x/2 -y/2 z/2]';
v6 = center_position + Cbo*[x/2 -y/2 -z/2]';
v7 = center_position + Cbo*[-x/2 y/2 -z/2]';
v8 = center_position + Cbo*[-x/2 -y/2 -z/2]';
V = [v1 v2 v3 v4 v5 v6 v7 v8]';

%define faces
F = [1 4 6 3;...
    1 2 7 4;...
    2 5 8 7;...
    8 6 3 5;...
    1 2 5 3;...
    4 7 8 6];


% Handle figure selection or creation
if isempty(p.Results.Figure) || ~ishandle(p.Results.Figure)
    fig = figure();
else
    fig = p.Results.Figure;
    if(~isequal(fig,gcf))
        figure(fig);
    end
end

patch('Faces',F,'Vertices',V,'FaceColor',p.Results.FaceColor, ...
      'EdgeColor',p.Results.PatchLineColor, ...
      'FaceAlpha',p.Results.FaceAlpha);
end