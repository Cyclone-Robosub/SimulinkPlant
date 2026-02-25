function Eul = quatToEul(qib)
%{
Inputs:
qib - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertia frame.

Outputs:
Eul - [roll, pitch, yaw]' The euler angles corresponding with a 3-2-1 
rotation sequence from the body to the inertial frame. 

Reference: 
De Ruiter - Spacecraft Dynamics and Control, Chapter 1
%}

%enforce column
qib = qib(:);

%calculate the rotation matrix
rotm = quatToRotm(qib);

%calculate the euler angles
Eul = rotmToEul(rotm);


end