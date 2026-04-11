function Q1 = calcQ1(q)
%{
This function impliments equation 4 from Quaternion-Based Control
Architecture for Determining Controllability/Maneuverability Limits by B.
J. Bacon at NASA Langely Research Center.

Inputs:
q - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertia frame.

Be careful not to confuse this function with calcQ2.

To use this matrix in equations 16 and 18 from the source, you must express
the error quaternion and desired quaternion rate in equation 16 and 18 as
[scalar; vector], not [vector; scalar] like is used elsewhere in this
codebase.
%}

%{
Map the quaternion notation used by Robosub [vector; scalar] to the
notatation used by the source.
%}
% Robosub Notation
eps = q(1:3);
eta = q(4);

% Source Notation
q0 = eta;
q1 = eps(1);
q2 = eps(2);
q3 = eps(3);

%Equation 4
Q1 = [-q1 -q2 -q3;...
    q0 -q3 q2;...
    q3 q0 -q1;...
    -q2 q1 q0];

end
