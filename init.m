% close all plots
close all
clc


% if the wrench and inertia matrix have changed, re-run these
%run("calculate_wrench.m");
%run("calculate_inertia.m");

% run constants.m
run("constants.m");

close all


%% Simulation initial conditions
%initial states for plant model
x0_e = [0, 0, 0]';
v0_e = [0, 0, 0]';
E0 = [0,0,0]'; %initial euler angles
w0 = [0, 0, 0]'; %initial angular velocity

%kalman filter initial conditions
P0 = 10*eye(3);
xhat0 = [0;0;0]'; 

%kalman filter constants
dt_filter = 0.01; %filter time step
H = [1 0 0;
    0 1 0]; %measurement matrix

%kalman filter parameters
Q = diag([0.0001, 0.0001, 0.1]); %process noise matrix (tune this)
R = [.1 0;
    0 .1]; %measurement noise matrix (tune this)


%IMU (combine these w/ Alex's stuff)
acc_vel_rw = 0.02/sqrt(3600);
acc_bias_instability = 19e-6*9.81; 
acc_noise = 60e-6*9.81;
gyro_rw = 0.16*2*pi/360/sqrt(3600);
gyro_noise = 5e-3*2*pi/360;
gyro_bias_instability = 1.5/3600/360;
mag_noise = 0.1;


%target states for controller
x_des = [0, 0, 0]';
E_des = [0, 0, 2]';
states_desired = [x_des;E_des];

%list of waypoints
waypoints = [0, -0, 0];

tol = 0.1; %tolerance when waypoint is considered "reached"

%% Test parameters 
% simulation parameters
do_gravity_flag = 0;
do_bouyancy_flag = 0;
do_imu_noise_flag = 0;
do_waypoint_control_flag = 1;

%time span and step
tspan = 100;
dt = 0.001; %simulation timestep
Dt = 0.01; %controller timestep
plot_dt = 0.1;

tic
results = sim('PID_LOOP_2024a.slx');
toc

%% unpack data
t = squeeze(results.E.Time);
E = squeeze(results.E.Data);
v_e = squeeze(results.v_e.Data);
w_b = squeeze(results.w_b.Data);
x_e = squeeze(results.x_e.Data);
desired_states = squeeze(results.desired_states.Data);
current_waypoint = squeeze(results.current_waypoint.Data);
intermediate_waypoint = squeeze(results.intermediate_waypoint.Data);
% for each simulation run create plots

% position vs time
figure
subplot(2,1,1)
plot(t,x_e)
hold on
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
%%
%position vs time, waypoint vs time, and intermediate waypoint vs time
figure
subplot(3,1,1)
plot(results.x_e.Time,results.x_e.Data(:,1))
hold on
plot(results.current_waypoint.Time,current_waypoint(1,:))
plot(results.intermediate_waypoint.Time,intermediate_waypoint(:,1))
xlabel("[s]")
ylabel("[m]")
title("X in NED")
subplot(3,1,2)
plot(results.x_e.Time,results.x_e.Data(:,2))
hold on
plot(results.current_waypoint.Time,current_waypoint(2,:))
plot(results.intermediate_waypoint.Time,intermediate_waypoint(:,2))
xlabel("[s]")
ylabel("[m]")
title("Y in NED")
subplot(3,1,3)
plot(results.x_e.Time,results.x_e.Data(:,3))
hold on
plot(results.current_waypoint.Time,current_waypoint(3,:))
plot(results.intermediate_waypoint.Time,intermediate_waypoint(:,3))
xlabel("[s]")
ylabel("[m]")
title("Z in NED")

%top down view
figure
plot3(results.x_e.Data(:,1),results.x_e.Data(:,2),results.x_e.Data(:,3))
hold on
plot3(current_waypoint(1,:),current_waypoint(2,:),current_waypoint(3,:),'Linestyle','none','Marker','.','MarkerSize',15)
plot3(intermediate_waypoint(:,1),intermediate_waypoint(:,2),intermediate_waypoint(:,3),'LineStyle','none','Marker','*','MarkerSize',10)
legend("Body Position","Current WP","Intermediate WP")
view(2)
xlim([-10,10])
ylim([-10,10])
title("3D Trajectory")
xlabel("X [m]")
ylabel("Y [m]")
% angular velocity vs time
% force vector vs time
% thrust vector vs time
% PID error vs time
% thruster duty cycle vs time

% call animation function
%animate_vehicle(initial_states,x_e,E)