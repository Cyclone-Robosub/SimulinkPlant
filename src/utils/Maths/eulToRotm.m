function rotm = eulToRotm(Eul)
%{
Inputs:
Eul - [roll, pitch, yaw]' The euler angles corresponding with a 3-2-1 
rotation sequence from the body to the inertial frame. 

Outputs:
rotm - The 3x3 rotation matrix from the body to the inertial frame.

Reference: 
De Ruiter - Spacecraft Dynamics and Control, Chapter 1
%}

phi = Eul(1);
theta = Eul(2);
psi = Eul(3);

C11 = cos(theta)*cos(psi);
C12 = cos(theta)*sin(psi);
C13 = -sin(theta);
C21 = sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi);
C22 = sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi);
C23 = sin(phi)*cos(theta);
C31 = cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi);
C32 = cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi);
C33 = cos(phi)*cos(theta);

C = [C11 C12 C13;C21 C22 C23;C31 C32 C33];
rotm = C;
end