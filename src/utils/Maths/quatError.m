function qe = quatError(q, qu)
%{
This function impliments equation 9 from Quaternion-Based Control
Architecture for Determining Controllability/Maneuverability Limits by B.
J. Bacon at NASA Langely Research Center.

Inputs:
q - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertial frame.

qu - [eps_u, eta_u]. The quaternion corresponding with the rotation matrix
from the target frame to the inertial frame.

To use the error quaternion in equations 16 and 18 from the source, you 
must express the error quaternion and desired quaternion rate in equation 
16 and 18 as[scalar; vector], not [vector; scalar] like is used elsewhere 
in this codebase.
%}

%{
Inverse quaternion. Note quatInverse.m uses the [vector; scalar] notation.
%}
qinv = quatInverse(q);

% Re-express the quaternion to match Matlab's notation to use quatMultiply
qinv_matlab = [qinv(4), qinv(1), qinv(2), qinv(3)];
qu_matlab = [qu(4), qu(1), qu(2), qu(3)];

% Matlab's built in quatMultiply uses [scalar, vector] and a row vector
qe_matlab = quatmultiply(qinv_matlab, qu_matlab);
qe_matlab = qe_matlab(:);

% Re-express into the notation used elsewhere in Robosub code
qe = [qe_matlab(2); qe_matlab(3); qe_matlab(4); qe_matlab(1)]; %[vector; scalar]

%ensure the error quaternion takes the shortest path
if(qe(4) < 0)
    qe = -qe;
end



