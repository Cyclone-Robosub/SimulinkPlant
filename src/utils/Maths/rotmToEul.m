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

%Pitch
theta = -asin(max(-1,min(1,C(1,3))));

%Check if near the singularity and force the attitude representation with
%phi = 0 to avoid gimbal lock
if (abs(cos(theta)) < 1e-6)
    phi = 0;
    psi = atan2(-C(2,1), C(2,2));
else
    phi = atan2(C(2,3), C(3,3));
    psi = atan2(C(1,2), C(1,1));
end


%enforce domain
phi = wrapToPi(phi);
theta = wrapToPi(theta);
psi = wrapToPi(psi);

Eul = [phi; theta; psi];
