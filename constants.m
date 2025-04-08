%% Constants 
g = 9.8067;
water_density = 997;

%% System Properties
m = 5.51 ; % kg
I_x = 1;
I_y = 1;
I_z = 1;
volume = 0.0074;
volume_center = [0, 0, 0.1];

%% Electronics
pwm_stop = 1500;
rot_noise = 60e-6;
lin_noise = 5e-3;

%% Math
wrench = [
         0         0    -1.0000   -0.2035   -0.2535         0
         0         0    -1.0000    0.2035   -0.2535         0
         0         0    -1.0000   -0.2035    0.2545         0
         0         0    -1.0000    0.2035    0.2545         0
   -0.7071   -0.7071         0   -0.0346    0.0346    0.2153
   -0.7071    0.7071         0    0.0346    0.0346   -0.2153
   -0.7071    0.7071         0    0.0346    0.0346    0.2220
   -0.7071   -0.7071         0   -0.0346    0.0346   -0.2220
];


drag_wrench = [
    0.4100         0         0         0         0         0
         0    0.5000         0         0         0         0
         0         0    1.2500         0         0         0
         0         0         0    0.5000         0         0
         0         0         0         0    1.0000         0
         0         0         0         0         0    0.5000
];

%% Simulation Setup
%parameters needed in Matlab functions
P.m = m;
P.I = diag([I_x,I_y,I_z]);
P.g = g;

%initial states in earth frame
x0_e = [0, 0, 0]';
v0_e = [0, 0, 0]';

%initial euler angles
E0 = [pi/6, pi/6, pi/6]';

%initial angular velocity
w0 = [0, 0, 0]';
%initial states for sensor processing unit 
x0_e_est = [0, 0, 0]';
v0_e_est = [0, 0, 0]';
E0_est = E0;

%target states
x_des = [1;1;1];
E_des = [0;0;0];
states_desired = [x_des;E_des];

%PID coefficients
kp_F = 1000;
ki_F = 50;
kd_F = 2000;
kp_T = 2000;
ki_T = 10;
kd_T = 4000;

%PID saturation and clamping
%to do - calculate reasonable values for this

%simulation time step

dt = 0.001;

%%
%IMU Struture and constants
IMU.accelMaxRating = 10^4 * g;
IMU.accelResolution = 122 * 10^-6 * g;
IMU.accelOffsetBias = 0;


