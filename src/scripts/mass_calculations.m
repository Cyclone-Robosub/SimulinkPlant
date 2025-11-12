%dimensions and local moments
%define conversion factor from in to m
in2m = 2.54/100;

%main cylinder
rm = 3.15*in2m;
lm = 18*in2m;
mm = 5.5; %measured using loadcell by Hull Team
Rm = [0 0 -4.53]'*in2m;
Im = diag([0.5*mm*rm^2, 1/12*mm*(3*rm^2+lm^2),1/12*mm*(3*rm^2+lm^2)]);

%thruster cylinders
rt = 1.6*in2m;
lt = 4.6*in2m;
mt = .427; %from datasheet, includes 1m of cord (not realistically at the cylinder's location)
Rt1 = [9.95 8 -1.675]'*in2m;
Rt2 = [9.95 -8 -1.675]'*in2m;
Rt3 = [-9.95 8 -1.675]'*in2m;
Rt4 = [-9.95 -8 -1.675]'*in2m;
Rt5 = [7.03 -4.95 1.93]'*in2m;
Rt6 = [7.03 4.95 1.93]'*in2m;
Rt7 = [-8.3 3.7 1.93]'*in2m;
Rt8 = [-8.3 -3.7 1.93]'*in2m;
%for simplicity, thrusters are treated as point masses for inertia matrix
%calculations, but not for buoyancy calculations.
It = zeros(3,3); 

%camera box
lc = 5*in2m;
wc = 5*in2m;
hc = 5*in2m;
mc = .7223; %measurements from hull team
Rc = [2 0 2.3]'*in2m;
Ic = diag([1/12*mc*(wc^2+hc^2), 1/12*mc*(lc^2 + hc^2), 1/12*mc*(lc^2+wc^2)]);



%DVL cylinder
rd = 1.7*in2m;
ld = 1.65*in2m;
Rd = [-4 0 1.5]'*in2m;
md = .17; %from datasheet, not including housing
Id = diag([1/12*md*(3*rd^2+ld^2), 1/12*md*(3*rd^2+ld^2),0.5*md*rd^2]);


%calculate any unaccounted for mass and assume it is part of the plate
mp = 3.143; % base plate mass from CAD
m = 15.06; %total mass measured by hull team
m_uncounted = m - (mm + md + mc + 8*mt + mp);
mp = mp + m_uncounted;

%base plate
lp = 18*in2m;
wp = 10.25*in2m;
hp = 0.25*in2m;
Rp = [0 0 0.125]'*in2m;
Ip = diag([1/12*mp*(wp^2+hp^2), 1/12*mp*(lp^2 + hp^2), 1/12*mp*(lp^2+wp^2)]);

%apply the parallel axis theorem to find the mass moment of inertia about
%the onshape origin
J = pat(Im,-Rm,mm) + pat(It,-Rt1,mt) + pat(It,-Rt2,mt)  + pat(It,-Rt3,mt) + ...
    pat(It,-Rt4,mt) + pat(It,-Rt5,mt) + pat(It,-Rt6,mt) + pat(It,-Rt7,mt) + ...
    pat(It,-Rt8,mt) + pat(Ic,-Rc,mc) + pat(Ip,-Rp,mp) + pat(Id,-Rd,md);

%{
WARNING - This is the moment of inertia about the onshape origin, not the
moment of inertia about the center of mass. We need to identify the vector
from onshape origin to the center of mass then use the parallel axis thm
again.
%}

%origin to center of mass
R_o2cm = (mm*Rm + mp*Rp + mc*Rc + md*Rd + mt*(Rt1 + Rt2 + Rt3 + Rt4 + Rt5 + Rt6 + Rt7 + Rt8))./m;


%calculate the vector from the center of mass to origin TODO - double check
%this
R_cm2o = -R_o2cm;

I = J - m*((dot(R_cm2o,R_cm2o)*eye(3) - R_cm2o*R_cm2o'));