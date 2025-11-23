function [Fb_buoy, Mb_buoy] =  buoyancy(Cbi, rho, V, R_cm2cv)

%{
Calculate the bouyant force and moment in the body coordinate system.

INPUTS
Cbi = the [3x3] rotation matrix from inertial coordinates to the body
coordinates 
R_cm2cv = the [3x1] position vector (m) of the vehicles center of volume relative to
the center of mass in body coordinates
rho = the density of water (kg/m^3)
V = the total vehicle displaced volume (m^3)

OUTPUTS
Fb_buoy = the [3x1] buoyant force vector (N) expressed in body coordinates
Mb_buoy = the [3x1] moment (Nm) due to the buoyant force expressed in body 
%}

%calculate the gravitation acceleration in the body frame
gb = Cbi*[0;0;9.81];

%buoyant force
Fb_buoy = -rho * V * gb;

%buoyant moment
Mb_buoy = cross(R_cm2cv,Fb_buoy);

end

