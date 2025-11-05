%{
For calculations related to buoyancy, mass, and wrenches refer to the
corresponding scripts located in the scripts folder. Anytime a change is
made to the vehicle, ALL THREE of these scripts must be updated.
%}

%max thrust force
max_thruster_force = 40;

%thruster voltage
battery_voltage = 14;

%Inertia Matrix TODO - Update this KJH
J = diag([0.2572,0.3723,0.3015]);

%mass TODO - Update this KJH
m = 10; %[kg]


%total volume
V = 0.0441; %[m3]
R_cv_o = [-0.0069;-0.0065;-0.093]; %position of the center of volume relative to the Onshape origin



%load forceToPWM fit data
force_struct = coder.load("src\utils\T200 Thruster Lookups\force.mat");
force_table = force_struct.forces;
pwm_struct = coder.load("src\utils\T200 Thruster Lookups\pwm.mat");
pwm_list = pwm_struct.pwm;
voltage_struct = coder.load("src\utils\T200 Thruster Lookups\voltage.mat","voltage");
voltage_list = voltage_struct.voltage;