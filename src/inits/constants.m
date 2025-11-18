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

%PID 
PID = [3 0.14 17 5.3;...
    4.3 0.19 23.5 5.3;...
    4.3 0.19 23.5 5.3;...
    37.7 18.3 17.2 195.8;...
    52.3 55.5 10.6 182.4;...
    100 294 42 60];

linear_saturation = 4;
rotational_saturation = 5;

%load physical data
run('physical_data_calculations');

%max thrust force
max_thruster_force = 10; %[N]
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

%vector from center of mass to center of volume for buoyancy calcs
R_cm2cv = R_o2cv-R_o2cm; % center of mass to center of volume

%load forceToPWM fit data
%to do, have the script search for these folders
try
    force_struct = coder.load(fullfile(prj_path_list.thruster_lookup_path,"force.mat"));
    force_table = force_struct.forces;
    pwm_struct = coder.load(fullfile(prj_path_list.thruster_lookup_path,"pwm.mat"));
    pwm_list = pwm_struct.pwm;
    voltage_struct = coder.load(fullfile(prj_path_list.thruster_lookup_path,"voltage.mat"),"voltage");
    voltage_list = voltage_struct.voltage;
catch
    error("Unable to load thruster data. Fix the path in your constants file.")
end