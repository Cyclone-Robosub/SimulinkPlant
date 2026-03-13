%{
This script is to develop the quaternion PID controller portion of the FB
Controller. The FB Controller uses a cascaded architecture where the
quaternion PID is used to define the angular velocity command for the next
controller.

The reference used to come up with this math is the paper
Quaternion-Based Control Architecture for Determining
Controllability/Maneuverability Limits published by B.J. Bacon at NASA 
Langley Research Center.
%}

% Initial States
Eul_0 = [rand()*pi-pi/2, rand()*pi-pi/2, rand()*pi-pi/2]'; %[roll, pitch, yaw] in radians
qib_0 = eulToQuat(Eul_0);
wb_0 = [0 0 0]'; %angular velocity of the body wrt to the inertial frame (rad/s)

% Target States
Eul_u = [0 0 pi]; %corresponding with a yaw to face the opposite direction
qib_u = eulToQuat(Eul_u); %#ok<NASGU>

% PID Gains
Kp = 3;
Ki = 0;
Kd = 0;

% Sim Setup
tspan = 5;
dt_sim = 0.001;
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim

results = sim('quaternion_pid_development_sim.slx');

qib = squeeze(results.qib.Data);
qib_u = squeeze(results.qib_u.Data)';
wb_u = squeeze(results.wb_u.Data);
t = results.qib.Time;

% Plots
figure()
subplot(4,1,1)
hold on
plot(t, qib(1,:))
plot(t, qib_u(1,:))
xlabel("Time (s)")
title("qvector(1)")
legend('State','Target')
subplot(4,1,2)
hold on
plot(t, qib(2,:))
plot(t, qib_u(2,:))
xlabel("Time (s)")
title("qvector(2)")
subplot(4,1,3)
hold on
plot(t, qib(3,:))
plot(t, qib_u(3,:))
xlabel("Time (s)")
title("qvector(3)")
subplot(4,1,4)
hold on
plot(t, qib(4,:))
plot(t, qib_u(4,:))
xlabel("Time (s)")
title("qscalar")
figure()
plot(t, wb_u(1,:))
hold on
plot(t, wb_u(2,:))
plot(t, wb_u(3,:))
legend('Wx', 'Wy', 'Wz')
title("Control Angular Velocity")
