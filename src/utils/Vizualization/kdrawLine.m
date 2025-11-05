function kdrawLine(vertex1, vertex2, varargin)
%{
Draws a line between the two vertices in the inertial (plot) frame. 
Optional arguments can be provided for the Figure, LineStyle, Color, and Weight.

Mandatory Inputs:
vertex1, vertex2 - Vertices specified as three element position vectors in
the plotting frame. Ex [1 2 3]

Optional Inputs:
'Figure' - figure object to plot on
'LineStyle' - plotting line style
'Color' - plot color

KJH 25/08/15
%}

%input parser
p = inputParser;
addRequired(p, 'vertex1',@(x) isvector(x) && isnumeric(x));
addRequired(p, 'vertex2',@(x) isvector(x) && isnumeric(x));

%optional inputs
addParameter(p, 'Figure', []);
addParameter(p, 'LineStyle','-');
addParameter(p, 'Color','k');
addParameter(p, 'Rotation',quaternion(1,0,0,0));

%parse
parse(p, vertex1, vertex2, varargin{:})

if(p.Results.Figure == [])
    f = figure();
else
    f = p.Results.Figure;
end

%hold on
if(~ishold(gca))
    hold on;
end

%unpack inputs and enforce row vectors for rotatepoint
vertex1 = p.Results.vertex1;
vertex1 = vertex1(:)';
vertex2 = p.Results.vertex2;
vertex2 = vertex2(:)';

%apply rotation
vertex1 = rotatepoint(p.Results.Rotation,vertex1);
vertex2 = rotatepoint(p.Results.Rotation,vertex2);

plot3([vertex1(1),vertex2(1)],[vertex1(2),vertex2(2)], [vertex1(3),vertex2(3)],'LineStyle',p.Results.LineStyle,'Color',p.Results.Color)



end