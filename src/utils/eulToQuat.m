function qib = eulToQuat(Eul)
%{
This function calculates the quaternion corresponding with the given Euler
angles. 

Inputs
Eul - [roll, pitch, yaw]' The euler angles corresponding with a 3-2-1 
rotation sequence from the body to the inertial frame. 

Outputs
qib - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertia frame.

Reference: 
De Ruiter - Spacecraft Dynamics and Control, Chapter 1
%}

%enforce column of Eul
Eul = Eul(:);

%find the rotation matrix
rotm = eulToRotm(Eul);

%find the quaternion
qib = rotmToQuat(rotm);