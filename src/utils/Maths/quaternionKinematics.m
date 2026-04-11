function dq = quaternionKinematics(q,w)
%{
This function computes the derivative of the quaternion dq from the unit
quaternion q and the angular velocity vector w for numerical integration.

Reference: de Ruiter Spacecraft Dynamics and Control

Changelog:
Created Nov 4, 2025 - KJH
Switched from Curtis to De Ruiter formulation for notational consistency
%}

%verify q is a column vector
q = q(:);
q_vector = q(1:3);
q_scalar = q(4);

dq_vector = 0.5*(q_scalar*eye(3) + vectorCross(q_vector))*w;

dq_scalar = -0.5*q_vector'*w;

dq = [dq_vector;dq_scalar];

end