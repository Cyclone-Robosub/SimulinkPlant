function Eul = rotmToEul(rotm)
%{
Inputs:
rotm - The 3x3 rotation matrix from the body to the inertial frame.

Outputs:
Eul - [roll, pitch, yaw]' The euler angles corresponding with a 3-2-1 
rotation sequence from the body to the inertial frame. 

Reference: 
De Ruiter - Spacecraft Dynamics and Control, Chapter 1
%}

C = rotm;

%avoid singularity
if(abs(C(3,3))<1e-3)
    C(3,3) = sign(C(3,3))*1e-3;
end

if(abs(C(1,1))<1e-3)
    C(1,1) = sign(C(1,1))*1e-3;
end

%calculate eulers
phi = atan(C(2,3)/C(3,3));
theta = -asin(C(1,3));
psi = atan(C(1,2)/C(1,1));

%enforce domain
phi = wrapToPi(phi);
theta = wrapToPi(theta);
psi = wrapToPi(psi);

Eul = [phi; theta; psi];
