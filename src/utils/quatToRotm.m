function rotm = quatToRotm(qib)

%{
This function calculates a rotation matrix from a quaternion.

Inputs:
qib - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertia frame.


Outputs:
rotm - The 3x3 rotation matrix from the body to the inertial frame.

Reference: 
De Ruiter - Spacecraft Dynamics and Control, Chapter 1
%}

%Enforce column
qib = qib(:);

%Unpack vector and scalar
eps = qib(1:3);
eta = qib(4); 

%Calculate the rotation matrix
C = (2*eta^2 - 1)*eye(3) + 2*eps*eps' + 2*eta*vectorCross(eps); %#ok<MHERM> %De Ruiter Eqn 1.33
%must be a "+" 2*eta..., not a "-" because deRuiter defines C for inertia
%to body and we need body to inertial
rotm = C;
end