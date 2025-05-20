%% Constants 

g = 9.8067;
P.g = g;
water_density = 997; 

%% System Properties

%to do: validate this
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


%rotation matrix from sensor frame to body frame
DCMbs = [-1 0 0;0 -1 0;0 0 -1];

%PID coefficients
%currently these are hard coded in the gain scheduler

%IMU Struture and constants
%Accelerometer
IMU.accelMaxRating =    10^4 * g; %[m/s^2]
IMU.accelResolution =   122e-6 * g; % [m/s^2] convert to m/s^2/LSB
IMU.accelOffsetBias =   0; %
IMU.accelVelRNDWalk =   0.02 / sqrt(3600); %[(m/s^2)/sqrt(Hz)]
IMU.accelBiasInstability = 19 * 1e-6 * g; %[m/s^2]
IMU.accelAccelRNDWalk = 60 * 1e-6 * g ; %[(m/s^2)*sqrt(Hz)] times


%Gyros
IMU.gyroResolution =      0.0076*pi/180; %[rad/hr]
IMU.gyroAccelBias =       0;
IMU.gyroAngleRNDWalk =    0.16 / sqrt(3600) * 2*pi/360; %[deg/sqrt(hr)]
IMU.gyroBiasInstability = 1.5 / 3600 * 2*pi / 360; %[rad/hr]
IMU.gyroRateRNDWalk =     5 * 1e-3 * 2*pi / 360 ; %[mdps/sqrt(hr)]

%Magnetometer
IMU.magsResolution =      0.3; %[uT]
IMU.magsAccelBias =       0; %measure this
IMU.magsRNDWalk =         0; %measure this
IMU.magsBiasInstability = 0; %measure this
IMU.magsRateRNDWalk =     0; %measure this

%AHRS (given RMS error, need to convert to PSD for noise block)
IMU.AHRS_roll_noise = 0; %measure this
IMU.AHRS_pitch_noise = 0; %measure this
IMU.AHRS_yaw_noise = 0; %measure this