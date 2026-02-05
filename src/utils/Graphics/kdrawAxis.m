function kdrawAxis(varargin)

p = inputParser;
addParameter(p,'Length',1,@isnumeric);
addParameter(p,'Rotation',quaternion([0 0 0],"euler","ZYX",'point'));
addParameter(p, 'Translation',[0 0 0], @(x) isvector(x) && isnumeric(x));
addParameter(p,'Color','k');
addParameter(p,'LineStyle','-');
addParameter(p,'LineWidth',1)
addParameter(p,'ShowLabels',1);
addParameter(p, 'Figure',[]);
addParameter(p, 'OneSided',0)
addParameter(p,'FontSize',12)


parse(p,varargin{:});

if(p.Results.Figure == [])
    f = figure();
else
    f = p.Results.Figure;
end
x1 = p.Results.Translation + rotatepoint(p.Results.Rotation, p.Results.Length.*[1 0 0]);
x2 = p.Results.Translation + rotatepoint(p.Results.Rotation, p.Results.Length.*[-1 0 0]);
y1 = p.Results.Translation + rotatepoint(p.Results.Rotation, p.Results.Length.*[0 1 0]);
y2 = p.Results.Translation + rotatepoint(p.Results.Rotation, p.Results.Length.*[0 -1 0]);
z1 = p.Results.Translation + rotatepoint(p.Results.Rotation, p.Results.Length.*[0 0 1]);
z2 = p.Results.Translation + rotatepoint(p.Results.Rotation, p.Results.Length.*[0 0 -1]);

kdrawVector(x1,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle,'LineWidth',p.Results.LineWidth)
kdrawVector(y1,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle,'LineWidth',p.Results.LineWidth)
kdrawVector(z1,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle,'LineWidth',p.Results.LineWidth)

if(~p.Results.OneSided)
    kdrawVector(x2,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle,'LineWidth',p.Results.LineWidth)
    kdrawVector(y2,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle,'LineWidth',p.Results.LineWidth)
    kdrawVector(z2,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle,'LineWidth',p.Results.LineWidth)

end

if(p.Results.ShowLabels)
    offset = p.Results.Length/10;
    text(x1(1)+offset,x1(2),x1(3),"x",'Color',p.Results.Color,'FontSize',p.Results.FontSize)
    text(y1(1),y1(2)+offset,y1(3),"y",'Color',p.Results.Color,'FontSize',p.Results.FontSize)
    text(z1(1),z1(2),z1(3)+offset,"z",'Color',p.Results.Color,'FontSize',p.Results.FontSize)
end


end