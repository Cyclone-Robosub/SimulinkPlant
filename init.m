% close all plots
close all
clc


% if the wrench and inertia matrix have changed, re-run these
run("calculate_wrench.m");
run("calculate_inertia.m");

% run constants.m
run("constants.m");
addpath('plot functions')
close all


%% Simulation initial conditions
%initial states for plant model and state estimator
x0_e = [1, 1, 0]';
v0_e = [0, 0, 0]';
E0 = [0, 0, pi/12]'; %initial euler angles
w0 = [2.1, 0, 0]'; %initial angular velocity

%target states for controller
x_des = [10,10,0]';
E_des = [0, 0, 0]';
states_desired = [x_des;E_des];


%list of waypoints
waypoints = [0, 0, 0];
tol = 0.1; %tolerance when waypoint is considered "reached"
bin_loc = [0;0];

%% Test parameters 
% simulation parameters
do_gravity_flag = 1;
do_bouyancy_flag = 1;
do_drag_flag = 1;
do_imu_noise_flag = 0;
do_control_force_flag = 1;
do_waypoint_control_flag = 1;
control_mode = 1; %1 = full state, %2 = z + angles

%time span and step
tspan = 100;
dt = 0.001; %simulation timestep
dt_controller = 0.01; %controller timestep
dt_plotting = 0.01;
dt_filter = 0.01;
dt_imu = 0.01;


tic
results = sim('PID_LOOP_2024b.slx');
toc

%% unpack data
t = squeeze(results.E.Time);
E = squeeze(results.E.Data);
v_e = squeeze(results.v_e.Data);
w_b = squeeze(results.w_b.Data);
x_e = squeeze(results.x_e.Data);
desired_states = squeeze(results.desired_states.Data); 
%flags = squeeze(results.flags.Data);
E_error = squeeze(results.E_error.Data);
yaw_torque = squeeze(results.yaw_torque.Data);
dfc_error = squeeze(results.dfc_error.Data);
do_DFC = squeeze(results.do_DFC);

% position vs time
figure
subplot(2,1,1)
plot(t,x_e)
hold on
title("Position in NED Inertial Frame")
xlabel("t [s]")
ylabel('[m]')
legend("X","Y","Z")

% euler angle vs time

subplot(2,1,2)
plot(t,E)
title("Euler Angles of the Body Frame wrt NED Frame")
xlabel("t [s]")
ylabel('Angle [rad]')
legend("Roll (phi)","Pitch (theta)","Yaw (psi)")

% velocity vs time

figure
subplot(2,1,1)
plot(t,v_e)
title("Velocity in NED Inertial Frame")
xlabel("t [s]")
ylabel("[m/s]")
legend('vx','vy','vz')


subplot(2,1,2)
plot(t,w_b)
title("Angular Velocity")
xlabel("t [s]")
ylabel("[rad/s]")
legend('wx','wy','wz')




%% Plotting
%plot_forces_and_torques(results)
%plot_individual_thruster_forces(results)
%plot_flags(results)
%plot_position(results)
%plot_velocity(results)
%plot_acceleration(results)
%plot_eulers(results)

%figure
%plot(t,E_error(1,:))
%hold on
%plot(t,E_error(2,:))
%plot(t,E_error(3,:))
%legend("Roll Error","Pitch Error","Yaw Error")
%xlabel("Time (s)")
%ylabel("Euler Angles (rad)")


%top down view
figure
plot3(results.x_e.Data(:,1),results.x_e.Data(:,2),results.x_e.Data(:,3))
%hold on
%plot3(current_waypoint(1,:),current_waypoint(2,:),current_waypoint(3,:),'Linestyle','none','Marker','.','MarkerSize',15)
%plot3(intermediate_waypoint(:,1),intermediate_waypoint(:,2),intermediate_waypoint(:,3),'LineStyle','none','Marker','*','MarkerSize',10)
%legend("Body Position","Current WP","Intermediate WP")

grid on

title("3D Trajectory")
xlabel("X [m]")
ylabel("Y [m]")
zlabel("Z [m]")

xyz = results.x_e.Data(:,1:3);
save('positions.txt','xyz','-ascii')

figure
subplot(2,1,1)
plot(t,dfc_error)
title("Error from Camera")
xlabel("t [s]")
ylabel("[m]")
legend('x_err','y_err')



subplot(2,1,2)
plot(t,do_DFC)
title("Do DFC Control Signal")
xlabel("t [s]")
ylabel("On/Off")
