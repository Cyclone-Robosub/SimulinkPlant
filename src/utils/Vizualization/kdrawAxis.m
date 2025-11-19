function kdrawAxis(varargin)

p = inputParser;
addParameter(p,'Length',1,@isnumeric);
addParameter(p,'Rotation',quaternion([0 0 0],"euler","ZYX",'point'));
addParameter(p, 'Translation',[0 0 0], @(x) isvector(x) && isnumeric(x));
addParameter(p,'Color','k');
addParameter(p,'LineStyle','-');
addParameter(p,'ShowLabels',1);
addParameter(p, 'Figure',[]);


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

kdrawVector(x1,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle)
kdrawVector(x2,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle)
kdrawVector(y1,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle)
kdrawVector(y2,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle)
kdrawVector(z1,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle)
kdrawVector(z2,'Color',p.Results.Color,'LineStyle',p.Results.LineStyle)

if(p.Results.ShowLabels)
    offset = p.Results.Length/10;
    text(x1(1)+offset,x1(2),x1(3),"x",'Color',p.Results.Color)
    text(y1(1),y1(2)+offset,y1(3),"y",'Color',p.Results.Color)
    text(z1(1),z1(2),z1(3)+offset,"z",'Color',p.Results.Color)
end


end