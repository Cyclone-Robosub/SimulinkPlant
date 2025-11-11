function [Fb_buoy, Mb_buoy] =  buoyancy(Cbi, rho, V, R_cm2cv, buoyancy_flag)

%{
Cbi - the rotation matrix from inertial coordinates to the body
Fb_buoy - the buoyant force vector expressed in body coordinates
Mb_buoy - the moment due to the buoyant force expressed in body coordinates 



@rho is the density of the water which can be found in the constant table
@V is the volume of boat
@bouyancy_flag is a toggle which help with testing. If it is 0, bouyancy
will not be considered
%}


gb = Cbi*[0;0;9.81];

Fb_buoy = -rho * V * gb;

Mb_buoy = cross(R_cm2cv,Fb_buoy);

if(buoyancy_flag==0)
    Mb_buoy=[0;0;0];
    Fb_buoy=[0;0;0];
end
%111

