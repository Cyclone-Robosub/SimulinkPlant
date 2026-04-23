function dq = quaternionKinematics(q,w)
%{
This function computes the derivative of the quaternion dq from the unit
quaternion q and the angular velocity vector w for numerical integration.

Reference: Crassidis Optimal Estimation of Dynamic Systems 2e

Inputs:
w - angular velocity of the body frame relative to the inertial frame
expressed in the body frame.

Changelog:
Created Nov 4, 2025 - KJH
%}

%verify q is a column vector
q = q(:);

%The equations from Crassidis use the quaternion as [vector; scalar]

% Equantion A.183 and A.184
Omega11 = -vectorCross(w);
Omega12 = w;
Omega21 = -w';
Omega22 = 0;

Omega = [Omega11, Omega12;...
    Omega21, Omega22];

dq = 0.5*Omega*q;

end