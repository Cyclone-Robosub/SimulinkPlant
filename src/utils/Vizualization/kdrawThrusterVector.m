function kdrawThrusterVector(radius, height, height_direction, center_position,varargin)

p = inputParser;
p.addRequired('radius');
p.addRequired('height');
p.addRequired('height_direction');
p.addRequired('center_position');

%{
p.addParameter('FaceColor','k');
p.addParameter('FaceAlpha',0.25);
p.addParameter('LineWidth',1);
p.addParameter('PatchLineColor','none');
p.addParameter('CircleLineColor','k');
p.addParameter('CirclePoints',100);
%}

p.addParameter('Color','R');

p.addParameter('Figure',[]);
p.addParameter('PWM',0.5);
parse(p,radius,height,height_direction,center_position,varargin{:});


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



end_point=center_position+p.Results.PWM*height_direction/norm(height_direction);


A=center_position(1);
B=center_position(2);
C=center_position(3);

D=end_point(1);
E=end_point(2);
F=end_point(3);

hold on
quiver3(A,B,C,D-A,E-B,F-C,0,'Color',p.Results.Color);
plot3(A,B,C,'Color',p.Results.Color,'Marker','.')
plot3(D,E,F,'Color',p.Results.Color,'Marker','none')




end