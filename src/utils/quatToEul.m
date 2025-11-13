function Eul = quatToEul(q)
%{
This function calculates the Euler angles corresponding to a 3-2-1 rotation
sequence from the quaternion.


Changelog:
Created on Nov 4, 2025 -KJH
%}

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

roll = atan2(2*(q4*q1 + q2*q3),1-2*(q1^2 + q2^2));
%clamp arg for pitch calc to avoid numerical issues
arg = 2*(q4*q2 - q3*q1);
arg = min([1 arg]); %upper bound at 1
arg= max([-1 arg]); %lower bound at -1
pitch = asin(arg);
yaw = atan2(2*(q4*q3 + q1*q2),1-2*(q2^2+q3^2));

Eul = [roll;pitch;yaw];
end