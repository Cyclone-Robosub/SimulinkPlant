close all
clc


run("calculate_wrench.m");
run("calculate_inertia.m");

run("constants.m")
close all


names = "PID_testing_" + ["X","Y","Z","roll","pitch","yaw","all","none","xyz","rpy"] + "_ts.csv";

state_error_X = [1;0;0;0;0;0]; %1 meter error in each body direction
state_error_Y = [0;1;0;0;0;0];
state_error_Z = [0;0;1;0;0;0];
state_error_roll = [0;0;0;1;0;0]; %1 meter error in each body angle
state_error_pitch = [0;0;0;0;1;0];
state_error_yaw = [0;0;0;0;0;1];
state_error_all = [1;1;1;1;1;1];
state_error_none = [0;0;0;0;0;0];
state_error_xyz = [1;1;1;0;0;0];
state_error_rpy = [0;0;0;1;1;1];


input_state_errors = [state_error_X,state_error_Y,state_error_Z,state_error_roll,state_error_pitch, ...
    state_error_yaw,state_error_all,state_error_none,state_error_xyz,state_error_rpy];

A = size(input_state_errors);

do_gravity_flag = 1;
do_bouyancy_flag = 1;
do_drag_flag = 1;
do_imu_noise_flag = 0;
do_control_force_flag = 1;
do_waypoint_control_flag = 1;
control_mode = 1; %1 = full state, %2 = z + angles

tspan = 0.1;
dt = 0.001; %simulation timestep
dt_controller = 0.01; %controller timestep
dt_plotting = 0.01;
dt_filter = 0.01;
dt_imu = 0.01;

tol = 0.1; %tolerance when waypoint is considered "reached"

tspan = 10

% if the wrench and inertia matrix have changed, re-run these
run("calculate_wrench.m");
run("calculate_inertia.m");

% run constants.m
run("constants.m");
addpath('plot functions')
close all


%% Simulation initial conditions
%initial states for plant model and state estimator
x0_e = [0,0,0]';
v0_e = [0,0,0]';
E0 = [0,0,0]'; %initial euler angles
w0 = [0,0,0]'; %initial angular velocity

controller_mode = 0;
DFC_error = [0;0]; %Should not matter because the controller mode is 0

tol = 0.1; %tolerance when waypoint is considered "reached"
%bin_loc = [2;2];

states = [0;0;0;0;0;0];

for i = 1:A(2)
%For looping through a bunch of state_errors
    waypoints = input_state_errors(:,i);

    tic
    results = sim('PID_Controller.slx');
    toc

    filename = names(i);

    writematrix([results.state_error.Data;results.pwm_cmd.Data],filename);
end