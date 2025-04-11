%% Constants 
g = 9.8067;
water_density = 997;

%% System Properties
%{functionality moved to inertia.m
m = 5.51 ; % kg
I_x = 1;
I_y = 1;
I_z = 1;
%}
volume = 0.0074;
volume_center = [0, 0, 0.1];

%% Electronics
pwm_stop = 1500;
rot_noise = 60e-6;
lin_noise = 5e-3;

%% Math
%{ 

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
%}

drag_wrench = [
    0.4100         0         0         0         0         0
         0    0.5000         0         0         0         0
         0         0    1.2500         0         0         0
         0         0         0    0.5000         0         0
         0         0         0         0    1.0000         0
         0         0         0         0         0    0.5000
];



%PID coefficients
kp_F = 2000;
ki_F = 10;
kd_F = 4000;

kp_T = 2000;
ki_T = 10;
kd_T = 4000;

%PID saturation and clamping
%to do - calculate reasonable values for this

%simulation time step

dt = 0.001;

%%
%IMU Struture and constants
%Accelerometer
IMU.accelMaxRating = 10^4 * g;
IMU.accelResolution = 122 * 10^-6 * g;
IMU.accelOffsetBias = 0;
IMU.accelVelRNDWalk = 0.02/(6*sqrt(360));

%Gyros
IMU.gyroResolution =      0.0076*pi/180;
IMU.gyroAccelBias =       0;
IMU.gyroAngleRNDWalk =    0.16*pi/180/sqrt(360);
IMU.gyroBiasInstability = 0;
IMU.gyroRateRNDWalk =     0;

%Magnetometer
IMU.magsResolution =      0.3;
IMU.magsAccelBias =       0;
IMU.magsRNDWalk =         0;
IMU.magsBiasInstability = 0;
IMU.magsRateRNDWalk =     0;


