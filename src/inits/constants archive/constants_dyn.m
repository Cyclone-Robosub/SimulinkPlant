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
I = [3.6142 0 -0.0009;...
    0 3.8165 0;...
    -0.0009 0 3.8551];
I_added = diag([0.0211,0.1721,1.8290]);
I = I + I_added;
invI = inv(I);

%force wrench
FT_wrench = [0 0 0 0 sqrt(2)/2 sqrt(2)/2 sqrt(2)/2 sqrt(2)/2;...
    0 0 0 0 sqrt(2)/2 -sqrt(2)/2 -sqrt(2)/2 sqrt(2)/2;...
    -1 -1 -1 -1 0 0 0 0];

%moment wrench
MT_wrench = [-0.2527   -0.2032    0.0425   -0.2527    0.1291   -0.0155   -0.1641   -0.1583;...
    0.2498    0.2003   -0.0454    0.2498   -0.1291   -0.0155   -0.1641    0.1583;...
    0         0         0         0   -0.0021    0.0622    0.3595   -0.0021];

%drag wrench estimate based on rectangular prism assumption
drag_wrench = diag([19.8131, 56.6159, 40.1531, 0.0689, 0.6689, 0.4282]);


%mass TODO - Update this KJH
m = 12.4513; %[kg]
M = diag([m m m]);
M_added = diag([2.4705 9.0585 9.0585]);
M = M + M_added;
invM = inv(M);

%density of water
rho = 998; %[kg/m3] at 20 C
%total volume
V = 0.0165; %[m3]

%vector from center of mass to center of volume for buoyancy calcs
R_o2cv = [-0.0011;-0.0011;-0.0011]; %Onshape origin to CV
R_o2cm = [0.0029; 0; -0.0206]; %Onshape origin to CM
R_cm2cv = R_o2cv-R_o2cm; % center of mass to center of volume

%load forceToPWM fit data
%to do, have the script search for these folders
force_struct = coder.load("SimulinkPlant/src/utils/T200 Thruster Lookups/force.mat");
force_table = force_struct.forces;
pwm_struct = coder.load("SimulinkPlant/src/utils/T200 Thruster Lookups/pwm.mat");
pwm_list = pwm_struct.pwm;
voltage_struct = coder.load("src/utils/T200 Thruster Lookups/voltage.mat","voltage");
voltage_list = voltage_struct.voltage;