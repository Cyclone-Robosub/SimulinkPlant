function delta_qe = deltaQuatError(q, qu)
%{
This function impliments equation 17 from Quaternion-Based Control
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
Quaternion error. Note quatError.m uses the [vector; scalar] notation.
%}
qe = quatError(q, qu);

%{
Apply a sign change to make the scalar of qe positive. This corresponds
with selecting the shorter rotational path to the target.
%}

%make sure not to accidently zero the quaternion if the scalar happens to be zero
if(~isequal(sign(qe(4)),0)) 
    qe_pos_scalar = sign(qe(4)).*qe;
else
    qe_pos_scalar = qe;
end

%get delta_qe (an intermediate variable in eqn 16 and 18 from the source.
%Again, this outputs in [vector; scalar] format
delta_qe = [0 0 0 1]' - qe_pos_scalar;




