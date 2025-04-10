%{
This script calculates the mass and inertia matrix of the vehicle about its
center of mass. The vehicle is modeled as a simple collection of uniform
density rigid bodies. 
%}

%dimensions [m,kg] to do: update this with more realistic values
density_al = 2700; %[kg/m3] 

%cylinder
rc = 10e-2;
lc = 50e-2;
mc = 2.2; %this was a random guess. update it

%plate
wp = 44e-2;
lp = 50e-2;
hp = 2e-2;
mp = 2.2;

%specify the position of each rigid body relative to the geometric center of base plate.
dp_2_geo_center = [0;0;0];
dc_2_geo_center = [0;0;rc+hp/2];

%calculate the position of the combined center of mass relative to the
%geometric center of the base plate.
dgeo_2_cm = [0;0;(mc*-(rc+hp/2)+mp*0)/(mc + mp)];

%vectors from component com to body cm
dp_2_com = dgeo_2_cm - dp_2_geo_center;
dc_2_com = -dgeo_2_cm + dc_2_geo_center;

%inertia matrix of each component about its center of mass
Ic = diag([1/2*mc*rc^2, 1/12*mc*(3*rc^2 + lc^2),1/12*mc*(3*rc^2 + lc^2)]);
Ip = diag([1/12*mp*(wp^2 + hp^2),1/12*mp*(lp^2 + hp^2),1/12*mp*(wp^2 + lp^2)]);

%use parallel axis theorem to get I about the body com 
P.I = parallelAxis(Ic, mc, dc_2_com) + parallelAxis(Ip, mp, dp_2_com);
P.m = mc + mp;
function Ip = parallelAxis(Icom, m, d)
    % this function was generated using chat gpt
    % Icom: 3x3 inertia tensor about the center of mass
    % m: mass of the object
    % d: 3x1 vector from COM to new axis (in meters)

   

    d = d(:); % Ensure column vector
    d_outer = d * d.'; % Outer product
    d_dot = dot(d, d); % ||d||^2

    Ip = Icom + m * (d_dot * eye(3) - d_outer);
end

