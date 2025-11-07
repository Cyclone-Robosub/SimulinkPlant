%TODO - replace placeholders with actual masses

%dimensions and local moments
%main cylinder
rm = 3.15;
lm = 18;
mm = 3.5; %PLACEHOLDER
Rm = [0 0 -4.53]';
Im = diag([0.5*mm*rm^2, 1/12*mm*(3*rm^2+lm^2),1/12*mm*(3*rm^2+lm^2)]);

%thruster cylinders
rt = 1.6;
lt = 4.6;
mt = .25; %PLACEHOLDER
Rt1 = [9.95 8 -1.675]';
Rt2 = [9.95 -8 -1.675]';
Rt3 = [-9.95 8 -1.675]';
Rt4 = [-9.95 -8 -1.675]';
Rt5 = [7.03 -4.95 1.93]';
Rt6 = [7.03 4.95 1.93]';
Rt7 = [-8.3 3.7 1.93]';
Rt8 = [-8.3 -3.7 1.93]';
%for simplicity, thrusters are treated as point masses for inertia matrix
%calculations, but not for buoyancy calculations.
It = diag([mt, mt, mt]);

%camera box
lc = 5;
wc = 5;
hc = 5;
mc = 2; %PLACEHOLDER
Rc = [2 0 2.3]';
Ic = diag([1/12*mc*(wc^2+hc^2), 1/12*mc*(lc^2 + hc^2), 1/12*mc*(lc^2+wc^2)]);

%base plate
lp = 18;
wp = 10.25;
hp = 0.25;
mp = 4; %PLACEHOLDER
Rp = [0 0 0.125]';
Ip = diag([1/12*mp*(wp^2+hp^2), 1/12*mp*(lp^2 + hp^2), 1/12*mp*(lp^2+wp^2)]);

%DVL cylinder
rd = 1.7;
ld = 1.65;
Rd = [-4 0 1.5]';
md = .5; %PLACEHOLDER
Id = diag([1/12*md*(3*rd^2+ld^2), 1/12*md*(3*rd^2+ld^2),0.5*md*rd^2]);

%apply the parallel axis theorem to find the mass moment of inertia about
%the onshape origin
J_in = pat(Im,Rm,mm) + pat(It,Rt1,mt) + pat(It,Rt2,mt)  + pat(It,Rt3,mt) + ...
    pat(It,Rt4,mt) + pat(It,Rt5,mt) + pat(It,Rt6,mt) + pat(It,Rt7,mt) + ...
    pat(It,Rt8,mt) + pat(Ic,Rc,mc) + pat(Ip,Rp,mp) + pat(Id,Rd,md);

%convert from kg*in^2 to kg*m^2
J_m = J_in.*(2.54/100)^2;

%{
WARNING - This is the moment of inertia about the onshape origin, not the
moment of inertia about the center of mass. We need to identify the vector
from onshape origin to the center of mass then use the parallel axis thm
again.
%}

%origin to center of mass
m = mm + mp + mc + md + 8*mt;
R_cm_o_in = (mm*Rm + mp*Rp + mc*Rc + md*Rd + mt*(Rt1 + Rt2 + Rt3 + Rt4 + Rt5 + Rt6 + Rt7 + Rt8))./m;

%convert to m
R_cm_o_m = R_cm_o_in.*(2.54/100);

%calculate the vector from the origin to the cm
R_o_cm = -R_cm_o_m;

I_cm = J_m - m*(dot(R_o_cm,R_o_cm)*eye(3) - outer(R_o_cm,R_o_cm));