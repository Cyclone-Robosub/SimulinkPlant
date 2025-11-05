function kdrawCylinder(radius, height, height_direction, center_position,varargin)
%{
Draw cylinder function used to render a cylinder in the currently active
plotting window given a radius, a height, a vector pointing in the
cylinder's height direction, and a center position.

Additional (optional) keyword arguments include:
FaceColor - color of faces used for patches and fills
FaceAlpha - transparancy of the face
LineWidth - width of lines
PatchLineColor - Color of patch and fill outlines, useful for debugging
CircleLineColor - Color of circular end outlines
CirclePoints - number of points used to render circles (100 by default)
Figure - which figure to plot on

For example use see kdrawCylinder_example.mlx

Future improvements:
- decrease execution time (currently can run at ~37 Hz)
- vectorize radius, height, height_direction, and center_position to allow
for multiple cylinder plots at once with the same optional input args. This
could be useful for plotting things like the thrusters. 

Credits:
- Code as part of the kdraw Toolbox by Kory Haydon for Cyclone Robosub
- Inspiration from https://github.com/emehiel/Matlab-Tools
- ChatGPT used for syntax help and some code snippets

%}
p = inputParser;
p.addRequired('radius');
p.addRequired('height');
p.addRequired('height_direction');
p.addRequired('center_position');

p.addParameter('FaceColor','k')
p.addParameter('FaceAlpha',0.25);
p.addParameter('LineWidth',1)
p.addParameter('PatchLineColor','none')
p.addParameter('CircleLineColor','k')
p.addParameter('CirclePoints',100)
p.addParameter('Figure',[])
parse(p,'radius','height','height_direction','center_position',varargin{:});



%figure creation, if necessary

% Handle figure selection or creation
if isempty(p.Results.Figure) || ~ishandle(p.Results.Figure)
    fig = figure();
else
    fig = p.Results.Figure;
    if(~isequal(fig,gcf))
        figure(fig);
    end
   
    
end



n = p.Results.CirclePoints;
[X,Y,Z] = cylinder(radius,n);
%apply Z scaling
Z = Z*height - height/2;

%find the rotation matrix to apply from the height_direction
height_direction = height_direction(:)/norm(height_direction);
rotation_axis = cross([0;0;1], height_direction);
rotation_angle = acos(dot([0;0;1],height_direction));

if(norm(rotation_axis)<1e-12 || norm(rotation_angle)<1e-12)
    %no need to rotate
    Reb = eye(3);
else
    Reb = axang2rotm([rotation_axis' rotation_angle]);
end

%unpack into vector to apply rotation

points_b = [X(1,:),X(2,:);Y(1,:),Y(2,:);Z(1,:),Z(2,:)];
points_e = Reb*points_b;

%pack back into X,Y,Z matrices
X = [points_e(1,1:n+1);points_e(1,n+2:end)];
Y = [points_e(2,1:n+1);points_e(2,n+2:end)];
Z = [points_e(3,1:n+1);points_e(3,n+2:end)];

%add the translation of the center
X = X + center_position(1);
Y = Y + center_position(2);
Z = Z + center_position(3);


%draw the cylindrical shell
[F,V,~] = surf2patch(X,Y,Z,'triangles');   % convert to patch
patch('Faces',F,'Vertices',V,'FaceColor',p.Results.FaceColor, ...
      'EdgeColor',p.Results.PatchLineColor, ...
      'FaceAlpha',p.Results.FaceAlpha);

if (~ishold(gca))
    hold on;
end

%draw the end circle outlines

odd_indices = 1:2:2*n+1;
even_indices = 2:2:2*n+2;
X_odd = X(odd_indices);
X_even = X(even_indices);
Y_odd = Y(odd_indices);
Y_even = Y(even_indices);
Z_odd = Z(odd_indices);
Z_even = Z(even_indices);
plot3(X_odd,Y_odd,Z_odd,'Color',p.Results.CircleLineColor,'LineStyle','-','Marker','none','LineWidth',p.Results.LineWidth)
plot3(X_even,Y_even,Z_even,'Color',p.Results.CircleLineColor,'LineStyle','-','Marker','none','LineWidth',p.Results.LineWidth)
%shade in end caps

bottom_center = [mean(X_even);mean(Y_even);mean(Z_even)];
top_center = [mean(X_odd);mean(Y_odd);mean(Z_odd)];



Xi_bottom = zeros(n+1,3);
Yi_bottom = zeros(n+1,3);
Zi_bottom = zeros(n+1,3);
Xi_top = zeros(n+1,3);
Yi_top = zeros(n+1,3);
Zi_top = zeros(n+1,3);


for i=1:n+1
    i1 = i;
    i2 = i+1; 
    if(i2 > n+1)
        i2 = i2-n;
    end
    
    Xi_bottom(i,:) = [bottom_center(1), X_even(i1), X_even(i2)];
    Yi_bottom(i,:) = [bottom_center(2), Y_even(i1), Y_even(i2)];
    Zi_bottom(i,:) = [bottom_center(3), Z_even(i1), Z_even(i2)];

    Xi_top(i,:) = [top_center(1), X_odd(i1), X_odd(i2)];
    Yi_top(i,:) = [top_center(2), Y_odd(i1), Y_odd(i2)];
    Zi_top(i,:) = [top_center(3), Z_odd(i1), Z_odd(i2)];

end


fill3(Xi_bottom,Yi_bottom, Zi_bottom,p.Results.FaceColor,'EdgeColor',p.Results.PatchLineColor,'FaceAlpha',p.Results.FaceAlpha)
fill3(Xi_top,Yi_top, Zi_top,p.Results.FaceColor,'EdgeColor',p.Results.PatchLineColor,'FaceAlpha',p.Results.FaceAlpha)



end