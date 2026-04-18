function [dXhat, dP] = simpleEKF(sensor_meas, xhat_k_minus, Phat_k_minus, new_drr_flag, Q)
%{
Inputs:
    sensor_meas - sensor_bus object containing the most recent sensor data
    xhat_k_minus - a priori estimate of the state vector [Ri, dRi, qib, wb]
    Phat_k_minus - a priori estimate of the error covariance matrix
    new_drr_flag - flag that is 1 if a new dead reckoning report is
    available with a new qib_meas and Rb_meas
    new_vr_flag - a flag that is 1 if a new velocity report is available
    with the new dRb_meas

TODO
    - Q input as a constant but should be modified with the covariances
    from the dvl reports

    % Work in progress, will not run yet
%}
% Unpack relevant sensor measurements
% TODO update the field names with correct values
wb_meas = sensor_meas.wb; %angular velocity from imu
ddRb_meas = sensor_meas.ddRb; %acceleration in body frame from imu
dRb_meas = sensor_meas.dRb; %velocity in body frame from dvl vr
qib_meas = sensor_meas.qib; %attitude from dvl drr
Rb_meas = sensor_meas.Rb; %position in body frame from dvl drr

%rotate the measurements to the inertial frame using the a priori qib
qibhat_k_minus = xhat_k_minus(7:10);
Cib = quatToRotm(qibhat_k_minus);
Ri_meas = Cib*Rb_meas;
dRi_meas = Cib*dRb_meas;
ddRi_meas = Cib*ddRb_meas;

%calculate the F matrix
F = [zeros(3), eye(3), zeros(3), zeros(3);...
    zeros(3), zeros(3), zeros(3), zeros(3);...
    zeros(3), zeros(3), vectorCross(wb_meas), -eye(3);...
    zeros(3), zeros(3), zeros(3), zeros(3)];
%assemble G matrix (this can be moved to constants)
G1 = zeros(3, 12);
G2 = [zeros(3), eye(3), zeros(3), zeros(3)];
G3 = [zeros(3), zeros(3), -eye(3), zeros(3)];
G4 = [zeros(3), zeros(3), zeros(3), eye(3)];
G = [G1;G2;G3;G4];



if(new_drr_flag)
    %calculate the a priori reduced state from the a priori state

    err_xhat_k_minus = [xhat_k_minus(1:3);xhat_k_minus(4:6);]

    %gain


    %update


else
    %state update
    %derivatives of the states based on a prior xhat and sensor data
    dRihat = dRihat_k_minus; %d/dt of inertial position
    ddRihat = ddRi_meas; %d/dt of inertial velocity
    dqibhat = quaternionKinematics(qibhat_k_minus, wb_meas); %d/dt of quaternion
    dwbhat = zeros(3,1); %d/dt of angular velocity

    dXhat = [dRihat; ddRihat; dqibhat; dwbhat];

    %covariance
    P = Phat_k_minus; %rename for readability
    dP = F*P + P*F' + G*Q*G';

end




end