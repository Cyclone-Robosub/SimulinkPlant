function qinv = quatInverse(q)
%{
This function calculates the inverse quaternion for the quaternion that is
provided. This is done simply by negating the vector portion of the
quaternion.

Inputs:
q - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertia frame.

Different reference material will change whether the scalar is first or the
vector is first. Make sure you orient the quaternion correctly or the
equations will not work.
%}

%{
Map the quaternion notation used by Robosub [vector; scalar] to the
notatation used by the source.
%}
% Robosub Notation
eps = q(1:3);
eta = q(4);

qinv = [-eps;eta];
end
