function [Fb_g, Mb_g] = gravity(Cbi, m, do_gravity_flag)
%{
@Cbi - the rotation matrix from inertial coordinates to the body
@Fb_g - the gravity force vector expressed in body coordinates
@Mb_g - the moment due to the gravity force expressed in body coordinates
@m - the mass of boat

%}
gb=Cbi*[0;0;9.81];
Fb_g=m*gb;
Mb_g=[0;0;0];

if(do_gravity_flag==0)
    Fb_g=[0;0;0];
end


end