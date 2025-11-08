%{
For calculations related to buoyancy, mass, and wrenches refer to the
corresponding scripts located in the scripts folder. Anytime a change is
made to the vehicle, ALL THREE of these scripts must be updated.
%}

%max thrust force
max_thruster_force = 40; %[N]

%thruster voltage
battery_voltage = 14; %[V]

%Inertia Matrix TODO - Update this KJH
J = [0.1474 0 -.0039;0 0.3085 0;-0.0039 0 0.3318];

%force wrench
FT_wrench = [0 0 0 0 sqrt(2)/2 sqrt(2)/2 sqrt(2)/2 sqrt(2)/2;...
    0 0 0 0 sqrt(2)/2 -sqrt(2)/2 -sqrt(2)/2 sqrt(2)/2;...
    -1 -1 -1 -1 0 0 0 0];

%moment wrench
MT_wrench = [-0.2242    0.1822   -0.2242    0.1822   -0.0340    0.0340    0.0340   -0.0340;...
    0.2623    0.2623   -0.2431   -0.2431    0.0340    0.0340    0.0340    0.0340;...
    0         0         0         0    0.2071   -0.2368    0.0610   -0.0907];

%mass TODO - Update this KJH
m = 14; %[kg]


%total volume
V = 0.0441; %[m3]
R_cv_o = [-0.0069;-0.0065;-0.093]; %position of the center of volume relative to the Onshape origin



%load forceToPWM fit data
%to do, have the script search for these folders
force_struct = coder.load("SimulinkPlant/src/utils/T200 Thruster Lookups/force.mat");
force_table = force_struct.forces;
pwm_struct = coder.load("SimulinkPlant/src/utils/T200 Thruster Lookups/pwm.mat");
pwm_list = pwm_struct.pwm;
voltage_struct = coder.load("src/utils/T200 Thruster Lookups/voltage.mat","voltage");
voltage_list = voltage_struct.voltage;