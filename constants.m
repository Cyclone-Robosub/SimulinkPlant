%% Constants 

g = 9.8067;
P.g = g;
water_density = 997; 

%% System Properties

%to do: 
volume = 0.0074; 
volume_center = [0, 0, -0.07]; %distance from center of mass in m


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
%currently these are hard coded in the gain scheduler

%IMU Struture and constants

%Accelerometer
IMU.accelMaxRating =    10^4 * g; %[m/s^2]
IMU.accelResolution =   122e-6 * g; % [m/s^2] convert to m/s^2/LSB
IMU.accelOffsetBias =   0; %
IMU.accelVelRNDWalk =   0.02 / sqrt(3600); %[(m/s^2)/sqrt(Hz)]
IMU.accelBiasInstability = 19 * 1e-6 * g; %[m/s^2]
IMU.accelAccelRNDWalk = 60 * 1e-6 * g / 100;  %[(m/s^2)*sqrt(Hz)] times



%Gyros
IMU.gyroResolution =      0.0076*pi/180; %[rad/hr]
IMU.gyroAccelBias =       0;
IMU.gyroAngleRNDWalk =    1.5 * 0.16 / sqrt(3600) * 2*pi/360; %[deg/sqrt(hr)]
IMU.gyroBiasInstability = 1.5 / 3600 * 2*pi / 360; %[rad/hr]
IMU.gyroRateRNDWalk =     5 * 1e-3 * 2*pi / 360 / 100; %[mdps/sqrt(hr)]

%Magnetometer
IMU.magsResolution =      0.3; %[uT]
IMU.magsAccelBias =       0; %measure this
IMU.magsRNDWalk =         0; %measure this
IMU.magsBiasInstability = 0; %measure this
IMU.magsRateRNDWalk =     0; %measure this

%{
%IMU Noiseless for testing
%Accelerometer
IMU.accelMaxRating =    10^4 * g; %[m/s^2]
IMU.accelResolution =   0; % [m/s^2] convert to m/s^2/LSB
IMU.accelOffsetBias =   0; %
IMU.accelVelRNDWalk =   0; %[(m/s^2)/sqrt(Hz)]
IMU.accelBiasInstability = 0; %[m/s^2]
IMU.accelAccelRNDWalk = 0; %[(m/s^2)*sqrt(Hz)] times


%Gyros
IMU.gyroResolution =      0; %[rad/hr]
IMU.gyroAccelBias =       0;
IMU.gyroAngleRNDWalk =    0; %[deg/sqrt(hr)]
IMU.gyroBiasInstability = 0; %[rad/hr]
IMU.gyroRateRNDWalk =     0; %[mdps/sqrt(hr)]

%Magnetometer
IMU.magsResolution =      0; %[uT]
IMU.magsAccelBias =       0; %measure this
IMU.magsRNDWalk =         0; %measure this
IMU.magsBiasInstability = 0; %measure this
IMU.magsRateRNDWalk =     0; %measure this

%}
%AHRS Sensor Noise (left as default until measured)
AHRS.accel_noise = 5.6037e-06;
AHRS.gyro_noise = 2.4412e-07;
AHRS.mag_noise = 3.5939e-05;
AHRS.gyro_drift_noise = 3.0462e-13;

%AHRS Environment Noise (left at defaults by block until I find better vals)
AHRS.env_lin_accel_noise = 0.00962361/1000;
AHRS.env_mag_disturbance_noise = 0.5/1000;
AHRS.env_lin_accel_decay_factor = 0.5;
AHRS.env_mag_disturbance_decay_factor = 0.5;
AHRS.env_mag_field_strength = 50;
