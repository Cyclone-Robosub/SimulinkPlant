function [Fb_bouy, Mb_bouy] =  Bouyancy_force(Cbi, rho, V, R_cv2cm, bouyancy_flag)

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

Fb_bouy = rho * V * gb;

Mb_bouy = cross(R_cv2cm,Fb_bouy);

if(bouyancy_flag==0)
    Mb_bouy=[0;0;0];
    Fb_bouy=[0;0;0];
end
%111

