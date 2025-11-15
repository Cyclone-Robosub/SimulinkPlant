function kdrawManny(Ri,Cib,varargin)
%plots Manny the Manatee in the inertial frame using the hardcoded
%dimensions measured from onshape, the position of the center of mass, and
%the rotation matrix.

%parse inputs
p = inputParser;
p.addRequired('Ri');
p.addRequired('Cib');
p.addParameter('FaceColor','k');
p.addParameter('FaceAlpha',0.25);
p.addParameter('LineWidth',1);
p.addParameter('PatchLineColor','k');
p.addParameter('CylinderPatchLineColor','none');
p.addParameter('Figure',[]);
p.addParameter('PWM',[]);
parse(p,'Ri','Cib',varargin{:});

% Handle figure selection or creation
if isempty(p.Results.Figure) || ~ishandle(p.Results.Figure)
    fig = figure();
else
    fig = p.Results.Figure;
    if(~isequal(fig,gcf))
        figure(fig);
    end
end



%dimensions and positions wrt the onshape origin
%main cylinder
rm = 3.15*(2.54/100);
lm = 18*(2.54/100);
Rm = [0 0 -4.53]'*(2.54/100);
kdrawCylinder(rm,lm,Cib*[1;0;0],Ri + Cib*Rm,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)

%thruster cylinders
rt = 1.6*(2.54/100);
lt = 4.6*(2.54/100);
Rt0 = [9.95 -8 -1.675]'*(2.54/100);
Rt1 = [9.95 8 -1.675]'*(2.54/100);
Rt2 = [-9.95 8 -1.675]'*(2.54/100);
Rt3 = [-9.95 -8 -1.675]'*(2.54/100);
Rt4 = [7.03 -4.95 1.93]'*(2.54/100);
Rt5 = [7.03 4.95 1.93]'*(2.54/100);
Rt6 = [-8.3 -3.7 1.93]'*(2.54/100);
Rt7 = [-8.3 3.7 1.93]'*(2.54/100);
kdrawCylinder(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt0,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt1,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt2,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt3,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[1 1 0]',Ri + Cib*Rt4,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[1 -1 0]',Ri + Cib*Rt5,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[1 -1 0]',Ri + Cib*Rt6,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)
kdrawCylinder(rt,lt,Cib*[1 1 0]',Ri + Cib*Rt7,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)

kdrawThrusterVector(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt0,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(1))
kdrawThrusterVector(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt1,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(2))
kdrawThrusterVector(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt2,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(3))
kdrawThrusterVector(rt,lt,Cib*[0 0 -1]',Ri + Cib*Rt3,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(4))
kdrawThrusterVector(rt,lt,Cib*[1 1 0]',Ri + Cib*Rt4,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(5))
kdrawThrusterVector(rt,lt,Cib*[1 -1 0]',Ri + Cib*Rt5,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(6))
kdrawThrusterVector(rt,lt,Cib*[1 -1 0]',Ri + Cib*Rt6,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(7))
kdrawThrusterVector(rt,lt,Cib*[1 1 0]',Ri + Cib*Rt7,'Figure',fig,'Color',p.Results.FaceColor,'PWM',p.Results.PWM(8))


%camera box
lc = 5*(2.54/100);
wc = 5*(2.54/100);
hc = 5*(2.54/100);
Rc = [2 0 2.3]'*(2.54/100);
Cbo = eye(3);
kdrawCuboid(lc,wc,hc,Cib*Cbo,Ri+Cib*Rc,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.PatchLineColor)

%base plate
lp = 18*(2.54/100);
wp = 10.25*(2.54/100);
hp = 0.25*(2.54/100);
Rp = [0 0 0.125]'*(2.54/100);
Cpb = eye(3);
kdrawCuboid(lp,wp,hp,Cib*Cpb,Ri+Cib*Rp,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.PatchLineColor)

%DVL cylinder
rd = 1.7*(2.54/100);
ld = 1.65*(2.54/100);
Rd = [-4 0 1.5]'*(2.54/100);
kdrawCylinder(rd,ld,Cib*[0;0;1],Ri + Cib*Rd,'Figure',fig,'FaceColor',p.Results.FaceColor,'LineWidth',p.Results.LineWidth,'PatchLineColor',p.Results.CylinderPatchLineColor)



end