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

%% Physical Data
%max thrust force
max_thruster_force = 40; %[N]

%Inertia Matrix (last updated 11/11/25 - KJH)
I = I + I_added;
invI = inv(I);

%mass (last updated 11/11/25 - KJH)
M = diag([m m m]);

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

%% Controller
ff_force_max = 2*sqrt(2)*max_thruster_force;

%tolerance for mode switching in the guidance law
Ri_e_tol = 1; %only leave this large for testing sliding maneuvers
Eul_e_tol = 10*pi/180; %If I make this too small the controller bounces a lot on edges. As low as 10 works

%Controller gains for position --> velocity
Rb_PID.Kp = 3; Rb_PID.Ki = 0.01; Rb_PID.Kd = 2;
Rb_PID.N = 100; %filter coefficient for the derivative term
Rb_PID.output_sat = 3; %PID saturation point for velocity output
Rb_PID.int_sat = 1; %integral term saturation limit


%Controller gains for velocity --> force %DRB
dRbx_PID.Kp = 20; dRbx_PID.Ki = 5; dRbx_PID.Kd = 0;
dRbx_PID.N = 100; %filter coefficient for the derivative term
dRbx_PID.output_sat = 120; %PID saturation point for velocity output
dRbx_PID.int_sat = 10; %integral term saturation limit

dRby_PID.Kp = 2; dRby_PID.Ki = 1; dRby_PID.Kd = 0;
dRby_PID.N = 100; %filter coefficient for the derivative term
dRby_PID.output_sat = 120; %PID saturation point for velocity output
dRby_PID.int_sat = 10; %integral term saturation limit

dRbz_PID.Kp = 6; dRbz_PID.Ki = 1; dRbz_PID.Kd = 0;
dRbz_PID.N = 100; %filter coefficient for the derivative term
dRbz_PID.output_sat = 120; %PID saturation point for velocity output
dRbz_PID.int_sat = 10; %integral term saturation limit

%Controller gains for quaternion --> angular velocity
qib_PID.Kp = 10; qib_PID.Ki = 2; qib_PID.Kd = 0.5;
qib_PID.N = 100; %filter coefficient for the derivative term (unused)
qib_PID.output_sat = 2*pi; %PID saturation point for velocity output
qib_PID.int_sat = pi/6; %integral term saturation limit

%Controller gains for angular velocity --> torque %WB
wb_PID.Kp = 20; wb_PID.Ki = 5; wb_PID.Kd = 0;
wb_PID.N = 100; %filter coefficient for the derivative term
wb_PID.output_sat = 40; %PID saturation point for velocity output
wb_PID.int_sat = 5; %integral term saturation limit

%pwm cmd clamping
pwm_lower_limit = 1100;
pwm_upper_limit = 1800;


%% IMU
Eul_bimu = [0 0 0];
Cbimu = eulToRotm(Eul_bimu); %Rotation matrix from the sensor frame to body frame
Cimub = Cbimu';

imu.T = 25;
imu.Bi = [ 27.5550,-2.4169,-16.0849];

imu.acc.meas_range = 16 *9.81; %+/- 16 g to m/s
imu.acc.res = 122e-6 * 9.81; %122 ug to m/s
imu.acc.const_bias = [0, 0, 0];
imu.acc.axes_skew = 100*eye(3);
%0.02 m/s/sqrt(hr) divided by sqrt(3600) to (m/s^2)/sqrt(Hz)
imu.acc.vel_rand_walk = 3.333e-4*ones(1,3); %aka noise density (m/s^2)/sqrt(Hz)
imu.acc.bias_inst = [0, 0, 0]; %(m/s^2) %need Allan Variance data to find this number
imu.acc.bias_inst_num_coeffs = 1;
imu.acc.bias_inst_den_coeffs = [1, -0.5];
imu.acc.acc_rand_walk = [0, 0, 0]; %(m/s^2)*sqrt(Hz) %need Allan Variance data to find this number
imu.acc.temp_bias = [0, 0, 0]; %(m/s^2)/C %not modeled
imu.acc.temp_scale_factor = [0, 0, 0]; % %/C

imu.gyro.max_read = 4000 * pi/180; %+/- 4000 deg/s to rad/s
imu.gyro.res = 0.0076 * pi/180; %0.0076 deg/s to rad/s
imu.gyro.const_bias = [0, 0, 0]; %
imu.gyro.axes_skew = 100*eye(3); 
imu.gyro.bias_from_acc = [0, 0, 0]; %(rad/s)/(m/s^2)
imu.gyro.angle_rand_walk = 4.654e-5*ones(1,3); %aka noise density ((rad/s)/sqrt(Hz))
imu.gyro.bias_inst = [0, 0, 0]; %rad/s %need Allan Variance data to find this number
imu.gyro.bias_inst_filter_num_coeffs = 1;
imu.gyro.bias_inst_filter_den_coeffs = [1, -0.5];
imu.gyro.rate_rand_walk = [0, 0, 0]; %((rad/s)*sqrt(Hz)) %need Allan Variance data to find this number
imu.gyro.temp_bias = [0, 0, 0]; %(rad/s)/C
imu.gyro.temp_scale_factor = [0, 0, 0]; % %/C

imu.mag.max_read = 2500;
imu.mag.res = 0.3; %(uT)/LSB
imu.mag.const_bias = [0, 0, 0]; %uT
imu.mag.axes_skew = 100*eye(3);
imu.mag.white_noise_psd = 0.2*ones(1,3); %aka noise density, (uT)/sqrt(Hz)
imu.mag.bias_inst = [0, 0, 0]; %uT %need Allan Variance data to find this number
imu.mag.bias_inst_filter_num_coeffs = 1;
imu.mag.bias_isnt_filter_den_coeffs = [1, -0.5];
imu.mag.rand_walk = [0, 0, 0]; %(uT)*sqrt(Hz) %need Allan Variance data to find this number
imu.mag.temp_bias = [0, 0, 0]; %uT/C
imu.mag.temp_scale_factor = [0, 0, 0]; % %/C

%% DVL
dvl.pool_depth = 2.25; %[m]
dvl.start_depth = 0.05; %[m] 

% dvl.noise_sigma = [0.01, 0.01, 0.015]'; %noise standard deviation 
% dvl.bias_sigma_ss = 0.01; %steady-state standard deviation of bias
dvl.bias_dt = 0.01; %update rate for bias update (dt_control)
dvl.noise_sigma = [0 0 0]';
dvl.bias_tau = 300;
dvl.bias_sigma_ss = 0;