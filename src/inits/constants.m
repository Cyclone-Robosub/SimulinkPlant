%{
This file contains all simulation parameters that refer to the state of the
vehicle that does not change during a simulation or do not refer to initial
conditions. 

constants.m without any modifiers is meant to be kept up to date. 
Constant files named constants_[modifier].m are used for specific test
cases that don't reflect the values used for the vehicle normally.
%}

% call getProjectPaths if it doesn't exist
if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

%% Controller
%tolerance for mode switching in the guidance law
Ri_e_tol = 2; %only leave this large for testing sliding maneuvers
Eul_e_tol = 10*pi/180; %If I make this too small the controller bounces a lot on edges. As low as 10 works

%Controller gains for position --> velocity
Kp_Rb = 3; 
Ki_Rb = .01; 
Kd_Rb = 2;
dRb_limit = 999;

%Controller gains for velocity --> force
Kp_dRx = 10;
Kp_dRy = 2;
Kp_dRz = 6;
linear_force_limits = [30*sqrt(2/2)*4, 30*sqrt(2/2)*4, 30*4];

%Controller gains for quaternion --> angular velocity
Kpq = 10;
Kiq = 2; %2
Kdq = 0.5;
quat_pid_integrator_limit = inf;

%Controller gains for angular velocity --> torque
Kp_w = 10;
Ki_w = 0;
Kd_w = 0;


%pwm cmd clamping
pwm_lower_limit = 1100;
pwm_upper_limit = 1800;

%% Physical Data
%load physical data
run('physical_data_calculations.m');

%max thrust force
max_thruster_force = 40; %[N]
ff_force_max = 2*sqrt(2)*max_thruster_force;
%thruster voltage
battery_voltage = 14; %[V]

%Inertia Matrix (last updated 11/11/25 - KJH)
I = I + I_added;
invI = inv(I);

%mass (last updated 11/11/25 - KJH)
M = diag([m m m]);

%based on shady equations - needs validation from textbook
%(last updated 11/11/25 - KJH)

M = M + M_added;
invM = inv(M);

%density of water
rho = 998; %[kg/m3] at 20 C

%gravity
gi = [0;0;-9.81];

%vector from center of mass to center of volume for buoyancy calcs
R_cm2cv = R_o2cv-R_o2cm; % center of mass to center of volume

%load forceToPWM fit data
%to do, have the script search for these folders
try
    voltage = coder.load(fullfile(prj_path_list.thruster_lookup_path,"voltage.mat"));
    voltage = table2array(voltage.t200_updatedS2);

    cw_pwm = coder.load(fullfile(prj_path_list.thruster_lookup_path,"cw_pwm.mat"));
    cw_pwm = table2array(cw_pwm.t200_updatedS2);

    ccw_pwm = coder.load(fullfile(prj_path_list.thruster_lookup_path,"ccw_pwm.mat"));
    ccw_pwm = table2array(ccw_pwm.t200_updatedS3);

    ccw_force = coder.load(fullfile(prj_path_list.thruster_lookup_path,"ccw_force.mat"));
    ccw_force = table2array(ccw_force.t200_updatedS3);
    
    cw_force = coder.load(fullfile(prj_path_list.thruster_lookup_path,"cw_force.mat"));
    cw_force = table2array(cw_force.t200_updatedS2);
catch
    error("Unable to load thruster data. Fix the path in your constants file.")
end

%% IMU
Eul_bimu = [0 0 0];
Cbimu = eulToRotm(Eul_bimu); %Rotation matrix from the sensor frame to body frame
Cimub = Cbimu';

imu.T = 25;
imu.Bi = [ 27.5550,-2.4169,-16.0849];

imu.acc.meas_range = Inf;
imu.acc.res = 0;
imu.acc.const_bias = [0, 0, 0];
imu.acc.axes_skew = 100*eye(3);
imu.acc.vel_rand_walk = [0, 0, 0]; %aka noise density (m/s^2)/sqrt(Hz)
imu.acc.bias_inst = [0, 0, 0]; %(m/s^2)
imu.acc.bias_inst_num_coeffs = 1;
imu.acc.bias_inst_den_coeffs = [1, -0.5];
imu.acc.acc_rand_walk = [0, 0, 0]; %(m/s^2)*sqrt(Hz)
imu.acc.temp_bias = [0, 0, 0]; %(m/s^2)/C
imu.acc.temp_scale_factor = [0, 0, 0]; % %/C

imu.gyro.max_read = Inf;
imu.gyro.res = 0;
imu.gyro.const_bias = [0, 0, 0];
imu.gyro.axes_skew = 100*eye(3); 
imu.gyro.bias_from_acc = [0, 0, 0]; %(rad/s)/(m/s^2)
imu.gyro.angle_rand_walk = [0, 0, 0]; %aka noise density ((rad/s)/sqrt(Hz))
imu.gyro.bias_inst = [0, 0, 0]; %rad/s
imu.gyro.bias_inst_filter_num_coeffs = 1;
imu.gyro.bias_inst_filter_den_coeffs = [1, -0.5];
imu.gyro.rate_rand_walk = [0, 0, 0]; %((rad/s)*sqrt(Hz))
imu.gyro.temp_bias = [0, 0, 0]; %(rad/s)/C
imu.gyro.temp_scale_factor = [0, 0, 0]; % %/C

imu.mag.max_read = Inf;
imu.mag.res = 0; %(uT)/LSB
imu.mag.const_bias = [0, 0, 0]; %uT
imu.mag.axes_skew = 100*eye(3);
imu.mag.white_noise_psd = [0, 0, 0]; %aka noise density, (uT)/sqrt(Hz)
imu.mag.bias_inst = [0, 0, 0]; %uT
imu.mag.bias_inst_filter_num_coeffs = 1;
imu.mag.bias_isnt_filter_den_coeffs = [1, -0.5];
imu.mag.rand_walk = [0, 0, 0]; %(uT)*sqrt(Hz)
imu.mag.temp_bias = [0, 0, 0]; %uT/C
imu.mag.temp_scale_factor = [0, 0, 0]; % %/C

%% DVL
dvl.pool_depth = 2.25; %[m]
dvl.start_depth = 0.05; %[m] 

dvl.noise_sigma = [0.01, 0.01, 0.015]'; %noise standard deviation 
dvl.bias_tau = 300; %bias drift time constant
dvl.bias_sigma_ss = 0.01; %steady-state standard deviation of bias
dvl.bias_dt = 0.01; %update rate for bias update (dt_control)
