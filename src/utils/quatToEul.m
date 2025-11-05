function Eul = quatToEul(q)
%{
This function calculates the Euler angles corresponding to a 3-2-1 rotation
sequence from the quaternion.

References:
Wikipedia

Changelog:
Created on Nov 4, 2025 -KJH
%}

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

roll = atan2(2*(q4*q1 + q2*q3),1-2*(q1^2 + q2^2));
pitch = -pi/2 + 2*atan2(sqrt(1+2*(q4*q2 - q1*q3)),sqrt(1-2*(q4*q2 - q1*q3)));
yaw = atan2(2*(q4*q3 + q1*q2),1-2*(q2^2+q3^2));

Eul = [roll;pitch;yaw];
end