function qk_plus_1 = discreteTimeQuatPropagation(q_meas, w_meas, reset, q0, dt_control)
%{
This function implements the discrete time quaternion propagation found in
Chapter 7.1.2 of Crassidis Optimal State Estimation of Dynamic Systems
(2e). This method is preferred over integrating the kinematic equations
found in the plant because the time step of the controller is 100 Hz and
the forward-euler method found in discrete time integrators is insufficient
with this low an update rate.

%% Initialization
%}
% qk is the estimate of the quaternion at time step k
persistent qk

if(isempty(qk))
    qk = q0;
end

%every time a new quaternion measurement is available, update qk
if(reset)
    qk = q_meas;
end

%% Quaternion Propagation
%updated quaternion
qk_plus_1 = OmegaMatrix(w_meas, dt_control)*qk;

%renormalize
qk_plus_1 = quatNormalization(qk_plus_1);

qk = qk_plus_1; %pass to next time step using the persistent variable

%% Helper Functions
function Omega = OmegaMatrix(wk, dt)
    norm_w = norm(wk);
    
    wk = wk(:);

    if(norm_w > 1e-10)
        Psik_plus = sin(0.5*norm_w*dt)/norm_w*wk;
    else
        Psik_plus = 0.5*dt*wk;
    end

    Omega11 = cos(0.5*norm_w*dt)*eye(3) - vectorCross(Psik_plus);
    Omega12 = Psik_plus;
    Omega21 = -Psik_plus';
    Omega22 = cos(0.5*norm_w*dt);


    Omega = [Omega11, Omega12;...
        Omega21, Omega22];
end

end