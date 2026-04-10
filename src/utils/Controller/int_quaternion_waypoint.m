function qib_u = int_quaternion_waypoint(Ri, Ri_wp)
%{
This function uses the position and attitude of the vehicle and the 
position of a waypoint to generate an intermediate quaternion waypoint that
points the x-axis of the vehicle body frame in the direction of the 
waypoint with a roll and pitch of zero.

Inputs:
Ri - position of the vehicle in the inertial frame
Ri_wp - position of the waypoint in the inertial frame

Outputs:
qib_u - intermediate quaternion waypoint for [roll = 0, pitch = 0, yaw =
yaw_target]
%}

%enforce column vectors
Ri = Ri(:);
Ri_wp = Ri_wp(:);

%project both vectors onto the xy-plane
Ri_xy = [Ri(1);Ri(2)];
Ri_wp_xy =[Ri_wp(1);Ri_wp(2)];

%calculate the vector between the two positions
diffi_xy = Ri_wp_xy - Ri_xy;

%calculate the angle from xi to diffi_xy
yaw_u = atan2(diffi_xy(2),diffi_xy(1));

%target yaw as an euler angle
roll_u = 0;
pitch_u = 0;
eul_u = [roll_u, pitch_u, yaw_u];

%calculate the quaternion
qib_u = eulToQuat(eul_u);

end
