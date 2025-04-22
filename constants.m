%% Constants 
g = 9.8067;
P.g = g;
water_density = 997;

%% System Properties

volume = 0.0074;
volume_center = [0, 0, 0.1];


% load wrench and inertia matrix
geometry_properties = load('geometry_properties.mat');
wrench = geometry_properties.wrench;
inverse_wrench= geometry_properties.inverse_wrench;

mass_properties = load('mass_properties.mat');
P.I = mass_properties.I;
P.m = mass_properties.m;


drag_wrench = [
    0.4100         0         0         0         0         0
         0    0.5000         0         0         0         0
         0         0    1.2500         0         0         0
         0         0         0    0.5000         0         0
         0         0         0         0    1.0000         0
         0         0         0         0         0    0.5000
];



%PID coefficients
kp_F = 18.5;
ki_F = 8.7;
kd_F = 9.7;

kp_T = 18.5;
ki_T = 8.7;
kd_T = 9.7;

%IMU Struture and constants
%Accelerometer
IMU.accelMaxRating =    10^4 * g;
IMU.accelResolution =   122 * 10^-6 * g;
IMU.accelOffsetBias =   0;
IMU.accelVelRNDWalk =   0.02/(6*sqrt(360));

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


