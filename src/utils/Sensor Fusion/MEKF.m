function [q_est, w_est, qhat_kp1, P_kp1, Bk_plus,debug] = MEKF(q_meas, w_meas, qk_minus, Bk_minus, Pk_minus, new_q_meas_flag, R, Q)

%renormalize qk_minus
qk_minus = quatNormalization(qk_minus);

%calculate angle error delta_alpha_meas from q_meas and qk_minus
delta_quat_meas = quatError(qk_minus, q_meas); %[vector; scalar]

%get the vector component
delta_quat_vector_meas = delta_quat_meas(1:3);
%calculate the angle error
delta_alphak_meas = 2*delta_quat_vector_meas; %[3x1]
debug = norm(delta_alphak_meas);
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
w_est = w_meas - Bk_plus;

%Propagate
q_est = qk_plus; %use this as the quaternion estimate 

% %Bk_minus is just Bk_plus returned through a unit delay

dt = 0.01;
w_norm = norm(w_est);
w_norm_dt = w_norm * dt;

if w_norm < 1e-10
    % Small angle limits (L'Hopital / Taylor expansion as w_norm -> 0)
    % sin(x)/x -> 1, (1-cos(x))/x^2 -> 1/2, (x-sin(x))/x^3 -> 1/6
    Psihatp = 0.5 * w_est * dt;
    cos_half = 1.0;
    Phi11 = eye(3);
    Phi12 = -eye(3) * dt;
else
    Psihatp= sin(0.5 * w_norm_dt) * w_est / w_norm;
    cos_half = cos(0.5 * w_norm_dt);
    Phi11 = eye(3) ...
                     - vectorCross(w_est) * sin(w_norm_dt) / w_norm ...
                     + vectorCross(w_est)^2 * (1 - cos(w_norm_dt)) / w_norm^2;
    Phi12 = vectorCross(w_est) * (1 - cos(w_norm_dt)) / w_norm^2 ...
                     - eye(3) * dt ...
                     - vectorCross(w_est)^2 * (w_norm_dt - sin(w_norm_dt)) / w_norm^3;
end

% Quaternion propagation
Omegabar1  = [cos_half * eye(3) - vectorCross(Psihatp), Psihatp];
Omegabar2  = [-Psihatp', cos_half];
Omegabar   = [Omegabar1; Omegabar2];
qhat_kp1   = Omegabar * q_est;

% Eqn 7.44
Gk = [-eye(3), zeros(3); zeros(3), eye(3)];

% Eqn 7.54
Phi21 = zeros(3);
Phi22 = eye(3);
Phi   = [Phi11, Phi12; Phi21, Phi22];

% Eqn 7.46
sigmav = 1e-3;
sigmau = 1e-6;
Qk = [(sigmav^2*dt + (1/3)*sigmau^2*dt^3)*eye(3), (0.5*sigmau^2*dt^2)*eye(3);
      (0.5*sigmau^2*dt^2)*eye(3),                  (sigmau^2*dt)*eye(3)];

% Eqn 7.43
P_kp1 = Phi * Pk_plus * Phi' + Gk * Qk * Gk';





end

