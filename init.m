% close all plots
close all
clc

% run constants.m
run("constants.m");

% if the wrench and inertia matrix have changed, re-run these
%run("calculate_wrench.m");
%run("calculate_inertia.m");


%% Sim Setup
close all

% configure test parameters
do_gravity_flag = 0;
do_bouyancy_flag = 0;
do_imu_noise_flag = 0;

tspan = 100;

dt = 0.001; %simulation timestep

Dt = 0.01; %controller timestep

%parameters needed in Matlab functions
P.g = g;

%initial states in earth frame
x0_e = [0, 0, 0]';
v0_e = [0, 0, 0]';

%initial euler angles
E0 = [0,0,0]';

%initial angular velocity
w0 = [0, 0, 0]';

%initial states for sensor processing unit 
x0_e_est = [0, 0, 0]';
v0_e_est = [0, 0, 0]';
E0_est = E0;

%target states
x_des = [1, 0, 0]';
E_des = [0, 0, 0]';
states_desired = [x_des;E_des];

%list of waypoints
waypoints = [5, 0, 0;...
             0, 0, 0;...
             -5, 0, 0;...
             0, 0, 0]';

tol = 0.1; %tolerance when waypoint is considered "reached"

% run simulation
tic
results = sim('PID_LOOP_2024a.slx');
toc

% unpack data
t = squeeze(results.E.Time);
E = squeeze(results.E.Data);
v_e = squeeze(results.v_e.Data);
w_b = squeeze(results.w_b.Data);
x_e = squeeze(results.x_e.Data);
desired_states = squeeze(results.desired_states.Data);
current_waypoint = squeeze(results.current_waypoint.Data);

% for each simulation run create plots

% position vs time
figure
subplot(2,1,1)
plot(t,x_e)
hold on
%plot(t,desired_states(1:3,:))
%plot(t,current_waypoint(1:3,:))
title("Position in NED Inertial Frame")
xlabel("t [s]")
ylabel('[m]')

% euler angle vs time

subplot(2,1,2)
plot(t,E)
title("Euler Angles of the Body Frame wrt NED Frame")
xlabel("t [s]")
ylabel('Angle [rad]')
legend("Roll (phi)","Pitch (theta)","Yaw (psi)")

    % velocity vs time

figure
plot(t,v_e)
title("Velocity in NED Inertial Frame")
xlabel("t [s]")
ylabel("[m/s]")

% angular velocity vs time
% force vector vs time
% thrust vector vs time
% PID error vs time
% thruster duty cycle vs time

% call animation function

