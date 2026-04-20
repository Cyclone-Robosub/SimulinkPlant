%{
This script gets a starting guess for Manatee's added rotational inertia
and mass by assuming Manny is a rectangular prism.
%}

% dimensionless added mass coefficients for rectangular prism
Cx = 0.15;
Cy = 0.55;
Cz = 0.55;
alpha = 0.2; 

%dimensions of a prism of the same volume as Manny
l = 0.4572;
w = 0.16;
h = 0.2256;
V = l*w*h;

rho = 998; %density of water


M_added = diag([rho*V*Cx, rho*V*Cy, rho*V*Cz]);

I_added = diag([rho*alpha*(w/2)^2*V, rho*alpha*(l/2)^2*V, rho*alpha*((l/2)^2 + (w/h)^2)*V]);