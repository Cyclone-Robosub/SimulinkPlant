function [q_est, w_est, dq, dP, Bk_plus,Kk] = MEKF(q_meas, w_meas, qk_minus, Bk_minus, Pk_minus, new_q_meas_flag, R, Q)
%calculate angle error delta_alpha_meas from q_meas and qk_minus
% delta_quat_meas = quatError(q_meas, qk_minus); %[vector; scalar]
delta_quat_meas = quatError(qk_minus, q_meas); %[vector; scalar]
%get the vector component
delta_quat_vector_meas = delta_quat_meas(1:3);
%calculate the angle error
delta_alphak_meas = 2*delta_quat_vector_meas; %[3x1]

%Hk (constant)
Hk = [eye(3), zeros(3)]; %[3x6]

if(new_q_meas_flag)
    %Kalman gain
    Kk = Pk_minus*Hk'*inv(Hk*Pk_minus*Hk' + R);
    

    %Covariance Update
    Pk_plus = (eye(6) - Kk*Hk)*Pk_minus;
    
    %measurement
    yk = delta_alphak_meas;

    %update intermediate state
    Delta_xk_plus = Kk*(yk - zeros(3,1)); %assumes the angle error of qk_minus is zero

    %Unpack delta_alphak_plus and Delta_Bk_plus
    delta_alphak_plus = Delta_xk_plus(1:3);
    Delta_Bk_plus = Delta_xk_plus(4:6);

    %quaternion update
    qk_plus = qk_minus + 0.5*quatXi(qk_minus)*delta_alphak_plus;

    %renormalize
    qk_plus = quatNormalization(qk_plus);

    %bias update
    Bk_plus = Bk_minus + Delta_Bk_plus;
else
    Kk = zeros(6,3);
    %Keep prior values
    qk_plus = qk_minus;
    Bk_plus = Bk_minus;
    Pk_plus = Pk_minus;
end

%Propagate
w_est = w_meas - Bk_plus;
q_est = qk_plus; %use this as the quaternion estimate 

dq = 0.5*quatXi(qk_plus)*w_est; %to be integrated outside of block and returned as qk_minus

%F matrix
Fk = [-vectorCross(w_est), -eye(3); zeros(3), zeros(3)];

%G matrix (constant)
G = [-eye(3), zeros(3); zeros(3), eye(3)];

dP = Fk*Pk_plus + Pk_plus*Fk' + G*Q*G'; %to be integrated outside of block and returned as qk_minus

%Bk_minus is just Bk_plus returned through a unit delay

end

