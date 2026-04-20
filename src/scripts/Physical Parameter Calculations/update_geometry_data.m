%{
Enter the values of measurements of various distances and masses of Manny.

This script will save the data in a structure called geometry.mat that is
accessed by calculator functions for added mass, buoyancy, drag, inertia,
and wrench matrices.

Note on coordinate frames.
Inertial Frame (i) - The North-East-Down local navigational frame. The
origin is set to be Manny's initial position upon starting a mission
file.

Pool (p) - The reference frame of the pool, typically with the x and y axis
aligned with two sides of the pool and a z-axis that points down. Physical
vectors in the pool frame (like measured waypoints) are to be rotated into
the inertial frame for use with navigation. The origin is set to be a
convenient location in the pool, such as a corner. 

Body (b) - The Forward-Right-Down reference frame attached to Manny. The
origin is set to be Manny's center of mass.

Onshape (o) - The reference frame used in the Onshape CAD software in which
Manny is modeled. The origin is taken as the origin of the CAD assembly.
This is a convenient frame for measuring things in CAD.

Thruster0 (t0) - The reference frame aligned with the body frame (b) but
translated so that the origin is positioned on top of thruster zero. This
is a convenient frame for measuring things on the physical robot.

DVL (dvl) - The reference frame of the DVL sensor.

IMU (imu) - The reference frame of the IMU sensor.

Note on geometry:
Each object is approximated as a uniform density rectangular prism or
circular cylinder. This means that the indicated position for each object
is both the object's center of mass and the geometric center used for
buoyancy and drag calculations. 
%}
%% Thrusters
% Position of the center of the thruster in the Onshape reference frame
RTo0 =  
RTo1 = 
RTo2 = 
RTo3 = 
RTo4 = 
RTo5 = 
RTo6 = 
RTo7 = 
RTo = [RTo0, RTo1, RTo2, RTo3, RTo4, RTo5, RTo6, RTo7];

% Translation between the onshape frame and the Thruster0 frame expressed
% in the onshape frame.
Ro2t0o = RTo0;

% Direction of each thruster in the Onshape reference frame
%{
Note, the direction here describes the direction of the thrusters "front"
or nose cone, NOT the direction of force when a PWM > 1500 is applied. An
additional mask is applied in the wrench_calculations.m script to account
for the different rotation direction of the thrusters that leads to this
difference. 
%}
NTo0 = 
NTo1 = 
NTo2 = 
NTo3 = 
NTo4 = 
NTo5 = 
NTo6 = 
NTo7 = 
NTo = [NTo0, NTo1, NTo2, NTo3, NTo4, NTo5, NTo6, NTo7]

%mass of each thruster in kg (does not account for distributed cord mass)
mass_T = 

%for inertia calculations, thrusters are considered point masses. For
%buoynacy, their size is approximated as a cylinder of volume equal to the
%displaced volume of the thruster.
length_disp_T = 
radius_disp_T = 

%% Cylinder
%Position of the geometric center of the cylinder in the onshape frame
Rco = 
length_c = %cylinder length
radius_c = %cylinder radius
mass_c = %cylinder mass

%% Downward Facing Camera (DFC) Box
Rdfco = 
length_dfc = %length (in forward direction)
width_dfc = %width (spanwise direction)
height_dfc = 
mass_dfc = 

%% DVL
Rdvlo = 
height_dvl = 
radius_dvl = 
mass_dvl = 
Codvl = %rotation matrix from dvl frame to onshape frame

%% Plate
Rpo = 
length_p = 
width_p = 
height_p = 
mass_p = 