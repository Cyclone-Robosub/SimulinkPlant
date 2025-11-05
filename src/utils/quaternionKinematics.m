function dq = quaternionKinematics(q,w)
%{
This function computes the derivative of the quaternion dq from the unit
quaternion q and the angular velocity vector w for numerical integration.

Reference: Curtis - Orbital Mechanics for Engineers 4e

Changelog:
Created Nov 4, 2025 - KJH
%}

%verify q is a column vector
q = q(:);

%calculate matrix Omega (Eqn 11.168)
w1 = w(1);
w2 = w(2);
w3 = w(3);

Omega = [0 w3 -w2 w1;...
         -w3 0 w1 w2;...
         w2 -w1 0 w3;...
         -w1 -w2 -w3 0];

%calculate dq (Eqn 11.167)
dq = 0.5*Omega*q;

end