%dimensions and local moments
%define conversion factor from in to m
m_meas = 0; %total mass measured by hull team (to be added)

%mass of any added balast needed to balance buoyancy
m_balast = 0;
m = m_meas+m_balast;

%pelican case
mp = 2.5; %mass in kg
%local mass moment of inertia
Ip = diag([1/12*mp*(wp^2+hp^2), 1/12*mp*(lp^2 + hp^2), 1/12*mp*(lp^2+wp^2)]);

%thruster cylinders
mt = .427; %from datasheet, includes 1m of cord (not realistically at the cylinder's location)
%for simplicity, thrusters are treated as point masses for inertia matrix
%calculations, but not for buoyancy calculations.
It = zeros(3,3);

%chassis frame
mc = 7.052;
Ic = diag([1/12*mc*(wc^2+hc^2), 1/12*mc*(lc^2 + hc^2), 1/12*mc*(lc^2+wc^2)]);

%calculate any unaccounted for mass and assume it is part of the plate
mp = 3.143; % base plate mass from CAD
m_uncounted = m - (mp + 8*mt + mp);
mp = mp + m_uncounted;


%apply the parallel axis theorem to find the mass moment of inertia about
%the onshape origin
J = pat(Ip,-Rp,mp) + pat(It,-Rt1,mt) + pat(It,-Rt2,mt)  + pat(It,-Rt3,mt) + ...
    pat(It,-Rt4,mt) + pat(It,-Rt5,mt) + pat(It,-Rt6,mt) + pat(It,-Rt7,mt) + ...
    pat(It,-Rt8,mt) + pat(Ic,-Rc,mc);

%{
WARNING - This is the moment of inertia about the onshape origin, not the
moment of inertia about the center of mass. We need to identify the vector
from onshape origin to the center of mass then use the parallel axis thm
again.
%}

%origin to center of mass
R_o2cm = (mp*Rp + mc*Rc + mt*(Rt1 + Rt2 + Rt3 + Rt4 + Rt5 + Rt6 + Rt7 + Rt8))./m;


%calculate the vector from the center of mass to origin TODO - double check
%this
R_cm2o = -R_o2cm;

I = J - m*((dot(R_cm2o,R_cm2o)*eye(3) - R_cm2o*R_cm2o'));