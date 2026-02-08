function lqr_error_state = calcLQRState(X_target, X_est)
%{
Prepares the lqr error state vector from the target state and state
estimate.

Inputs:
X_target = [xi yi zi roll pitch yaw] (rate target assumed to be zero)
X_est = [xb yb zb dxb dyb dzb q0 q1 q2 q3 wbx wby wbz]

Outputs:
lqr_error_state = [Rb-Rbref,dRb-dRbref,angle_error,wb-wbref]
%}

%unpack

lqr_error_state = zeros(12,1);

%find the rotation matrix
Cib = quat2rotm([X_est(7) X_est(8) X_est(9) X_est(10)]);

%rotate the target position to body coordinates
Rb_target = Cib*[X_target(1);X_target(2);X_target(3)];

%define rate targets
dRb_target = zeros(3,1);
wb_target = zeros(3,1);

%define the target quaternion from the Euler angles
q_target = eul2quat([X_target(6), X_target(5), X_target(4)]);
inv_q_target = [q_target(1) -q_target(2:4)];
q = X_est(7:10)';

%re-order so the scalar is at the front
q = [q(4) q(1) q(2) q(3)];

q_error = quatmultiply(inv_q_target,q);
angle_error = 2*q_error(2:4)';

wb_est = X_est(11:13);

%combine errors
lqr_error_state = [X_est(1:3)-Rb_target;X_est(4:6)-dRb_target;angle_error;wb_est-wb_target];

end