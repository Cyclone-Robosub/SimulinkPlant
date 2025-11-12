%{
This file contains all simulation parameters that refer to the state of the
vehicle that does not change during a simulation or do not refer to initial
conditions. 

constants.m without any modifiers is meant to be kept up to date. 
Constant files named constants_[modifier].m are used for specific test
cases that don't reflect the values used for the vehicle normally.
%}

%max thrust force
max_thruster_force = 40; %[N]

%thruster voltage
battery_voltage = 14; %[V]

%Inertia Matrix (last updated 11/11/25 - KJH)
I = [0.2031 0 0.0002;...
    0 0.4383 0;...
    0.0002 0 0.4773];
I_added = diag([0.0211,0.1721,1.8290]);
I = I + I_added;
invI = inv(I);

%force wrench (last updated 11/11/25 - KJH)
FT_wrench = [0 0 0 0 sqrt(2)/2 sqrt(2)/2 sqrt(2)/2 sqrt(2)/2;...
    0 0 0 0 sqrt(2)/2 -sqrt(2)/2 -sqrt(2)/2 sqrt(2)/2;...
    -1 -1 -1 -1 0 0 0 0];

%moment wrench (last updated 11/11/25 - KJH)
MT_wrench = [-0.2032   0.2032    -0.2032  0.2032    -0.0608  0.0608   0.0608   -0.0608;...
    0.2577    0.2577   -0.2477   -0.2477    0.0608    0.0608    0.0608    0.0608;...
    0         0         0         0    0.2187   -0.2187    0.0791   -0.0791];

%drag wrench estimate based on rectangular prism assumption
%(last updated 11/11/25 -KJH)
%TO DO - validate the calculations in the drag script 
%rotational components complete guesses tuned via eyeballing it
drag_wrench = diag([19.8131, 56.6159, 40.1531, 10, 20, 20]);


%mass (last updated 11/11/25 - KJH)
m = 15.06; %[kg] 
M = diag([m m m]);

%based on shady equations - needs validation from textbook
%(last updated 11/11/25 - KJH)
M_added = diag([2.4705 9.0585 9.0585]);
M = M + M_added;
invM = inv(M);

%density of water
rho = 998; %[kg/m3] at 20 C

%total displaced volume (last updated 11/11/25 -KJH)
V = 0.0122; %[m3]

%vector from center of mass to center of volume for buoyancy calcs
R_o2cv = [-0.0065; 0; -0.0757]; %Onshape origin to CV
R_o2cm = [-0.0005; 0; -0.0369]; %Onshape origin to CM
R_cm2cv = R_o2cv-R_o2cm; % center of mass to center of volume

%load forceToPWM fit data
%to do, have the script search for these folders
try
    force_struct = coder.load("SimulinkPlant/src/utils/T200 Thruster Lookups/force.mat");
    force_table = force_struct.forces;
    pwm_struct = coder.load("SimulinkPlant/src/utils/T200 Thruster Lookups/pwm.mat");
    pwm_list = pwm_struct.pwm;
    voltage_struct = coder.load("src/utils/T200 Thruster Lookups/voltage.mat","voltage");
    voltage_list = voltage_struct.voltage;
catch
    error("Unable to load thruster data. Fix the path in your constants file.")
end