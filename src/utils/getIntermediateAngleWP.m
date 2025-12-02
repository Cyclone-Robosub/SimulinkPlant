function qib_target = getIntermediateAngleWP(R_wp,R_i)
%{
Compute the quaternion that rotates the body x-axis toward the waypoint.
Roll is constrained to zero.

Input:
R_wp = Position of the waypoint in the inertial frame [3x1] (m)
R_i = Position of the robot in the inertial frame [3x1] (m)

Output:
qib_target = The target quaternion rotating from the body to the inertial frame [4x1]
qib_target(1:3) = Quaternion vector
qib(4) = Quaternion scalar

%}

% Vector from robot to waypoint
R_i2wp = R_wp - R_i;

if norm(R_i2wp) < 1e-9
    error("Waypoint coincident with robot. Direction undefined.");
end
n_i2wp = R_i2wp / norm(R_i2wp);     % find the direction

% Forward–Right–Down body frame
% Inertial frame: x-forward, y-right, z-up

% Yaw and pitch for roll = 0
yaw   = atan2(n_i2wp(2), n_i2wp(1)); 
pitch = atan2(-n_i2wp(3), sqrt(n_i2wp(1)^2 + n_i2wp(2)^2));
roll  = 0;

% Quaternion from yaw–pitch–roll, Z-Y-X sequence
cy = cos(yaw/2);  sy = sin(yaw/2);
cp = cos(pitch/2); sp = sin(pitch/2);
cr = cos(roll/2);  sr = sin(roll/2);

qib_target = [ ...
    sr*cp*cy - cr*sp*sy;   % qx
    cr*sp*cy + sr*cp*sy;   % qy
    cr*cp*sy - sr*sp*cy;   % qz
    cr*cp*cy + sr*sp*sy ]; % qw
