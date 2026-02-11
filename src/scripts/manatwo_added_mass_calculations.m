%{
This script gets a starting guess for Manatwo's added rotational inertia
and mass by assuming Manny is a rectangular prism.
%}

% dimensionless added mass coefficients for rectangular prism
Cx = 0.15;
Cy = 0.55;
Cz = 0.55;
alpha = 0.2; 

%dimensions of a prism of the same volume as Manatwo
% y-axis
l = 0.5588;
% x-axis
w = 0.6604;
% z-axis 
h = 0.3429;
V = l*w*h;

rho = 998; %density of water


M_added = diag([rho*V*Cx, rho*V*Cy, rho*V*Cz]);

I_added = diag([rho*alpha*(w/2)^2*V, rho*alpha*(l/2)^2*V, rho*alpha*((l/2)^2 + (w/h)^2)*V]);