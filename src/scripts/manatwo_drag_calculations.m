%{
This script gets a starting guess for Manatwo's drag matrix by assuming 
Manatwo is a rectangular prism.
%}

%dimensions of a prism of the same volume as Manatwo
l = 0.6096;
a = l/2;
w = 0.5588;
b = w/2;
h = 0.3429;
c = h/2;
V = l*w*h;

rho = 998; %density of water

Cd = 1.1; %assumed for linear

%projected areas 
Ayz = 4*b*c;
Axz = 4*a*c;
Axy = 4*a*b;

%linear drag portion
D_lin = 0.5*rho*diag([Cd*Ayz Cd*Axz Cd*Axy]);

Cr = 0.2; %assumed for rotational

%rotational drag reference lengths
Lyz = sqrt(b^2 + c^2);
Lxz = sqrt(a^2 + c^2);
Lxy = sqrt(a^2 + b^2);

D_rot = 0.5*rho*diag([Cr*Ayz*Lyz^2 Cr*Axz*Lxz^2 Cr*Axy*Lxy^2]);

%fudge factor to better match experimental data
D_rot = D_rot + diag([10,20,20]);
drag_wrench = [[D_lin, zeros(3)];[zeros(3), D_rot]];