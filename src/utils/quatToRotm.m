function Cib = quatToRotm(q)
%{
This function uses algorithm 11.1 from Curtis - Orbital Mechanics for
Engineers to compute the rotation matrix from the body to inertial frame
Cib such that Ri = Cib*Rb. 

The quaternion vector is q(1:3) and the quaternion scalar is q(4).

Changelog:
Created on Nov 4, 2025 - KJH
%}

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

%define matrix components
C11 = q1^2 - q2^2 - q3^2 + q4^2;
C12 = 2*(q1*q2 - q3*q4);
C13 = 2*(q1*q3 + q2*q4);
C21 = 2*(q2*q1 + q3*q4);
C22 = -q1^2 + q2^2 - q3^2 + q4^2;
C23 = 2*(q2*q3 - q1*q4);
C31 = 2*(q3*q1 - q2*q4);
C32 = 2*(q3*q2 + q1*q4);
C33 = -q1^2 - q2^2 + q3^2 + q4^2;

%assemble matrix
Cib = [C11 C12 C13;C21 C22 C23; C31 C32 C33];

end