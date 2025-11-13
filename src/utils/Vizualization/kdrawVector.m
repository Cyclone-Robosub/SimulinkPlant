function kdrawVector(vector, varargin)
%{
This is a wrapper function for "quiver3" that plots a vector and 
direction-indicating head.

Mandatory Inputs:
vector - a three element vector (assumed to be in the inertial frame unless
a rotation is specified)

Optional Inputs:
'Figure' - figure object to plot on
'LineStyle' - plotting line style
'Color' - plot color
'Translation' - the translation of the vector tail in the inertial frame
'Rotation' - the quaternion rotating the from the frame 'vector' is
expresed in to the inertial frame
%}

%input parser
p = inputParser;
addRequired(p, 'vector',@(x) isvector(x) && isnumeric(x));

%optional inputs
addParameter(p, 'Figure',[]);
addParameter(p, 'LineStyle','-');
addParameter(p, 'Color','k');
addParameter(p, 'Translation',[0 0 0], @(x) isvector(x) && isnumeric(x));
addParameter(p,'Rotation',quaternion(1, 0, 0, 0));
addParameter(p,'Scaling',0.1,@isnumeric);
addParameter(p,'VectorHead',1)

%parse
parse(p, vector, varargin{:});

%create a new figure if necessary
if(p.Results.Figure == [])
    f = figure();
else
    f = p.Results.Figure;
end

%initial point

vertex1 = p.Results.Translation;
x1 = vertex1(1);
y1 = vertex1(2);
z1 = vertex1(3);

%terminal point
vertex2 = vertex1 + rotatepoint(p.Results.Rotation, p.Results.vector(:)');
x2 = vertex2(1);
y2 = vertex2(2);
z2 = vertex2(3);

hold on
quiver3(x1,y1,z1,x2-x1,y2-y1,z2-z1,0,'Color',p.Results.Color)
plot3(x1,y1,z1,'Color',p.Results.Color,'Marker','.')
plot3(x2,y2,z2,'Color',p.Results.Color,'Marker','none')
end