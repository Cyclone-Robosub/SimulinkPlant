%% Inputs
q_meas = [0 0 0 1]';
wb_meas = zeros(3,1);
qhat_k_minus = [0 0 0 1]';
Pk_minus = zeros(6);
Bk_minus = zeros(3,1);
Dxk_hat_minus = zeros(6,1); 
new_dvl_meas_flag = 1;

%Matrices
Hk = HkEKF();
Rk = RkEKF();
Fk = FkEKF();
Gk = GkEKF();
Qk = QkEKF();


if(new_dvl_meas_flag)
    %Matrices
    yk = ykEKF(qhat_k_minus, q_meas); 
 

    %Kalman gain
    Kk = Pk_minus*Hk'*inv(Hk*Pk_minus*Hk' + Rk);

    %Update
    Dxk_hat_plus = Dxk_hat_minus + Kk*(yk - Dxk_hat_minus(1:3));
    Pk_plus = (eye(6) - Kk*Hk)*Pk_minus;
else
    %skip the update step
    Dxk_hat_plus = Dxk_hat_minus;
    Pk_plus = Pk_minus;

end

%no update for the quaternion used as the reference for yk and dq
qhat_k_plus = qhat_k_minus;

%Propagation
dB = zeros(3,1); %bias 
dP = Fk*Pk_plus + Pk_plus*Fk' + Gk*Qk*Gk';
dq = quatKinematicsEKF(Dxk_hat_plus,qhat_k_plus, wb_meas); %q extracted from Dxk_hat_pl
