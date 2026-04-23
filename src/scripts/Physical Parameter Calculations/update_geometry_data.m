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
%Rotation matrix between the onshape frame and body frame
geo.Cbo = eulToRotm([pi, 0, pi]);

%Total Mass
geo.m_total = 15.1;

%% Thrusters
% Position of the center of the thruster in the Onshape reference frame
geo.RTo0 = [-0.254, -0.203, 0.027]'; %[m]
geo.RTo1 = [-0.254, 0.203, 0.027]';
geo.RTo2 = [0.254, -0.203, 0.027]';
geo.RTo3 = [0.254, 0.203, 0.027]';
geo.RTo4 = [-0.177, -0.128, -0.049]';
geo.RTo5 = [-0.177, 0.128, -0.049]';
geo.RTo6 = [0.179, -0.126, -0.049]';
geo.RTo7 = [0.179, 0.126, -0.049]';
geo.RTo = [geo.RTo0, geo.RTo1, geo.RTo2, geo.RTo3, geo.RTo4, geo.RTo5, geo.RTo6, geo.RTo7];

% Translation between the onshape frame and the Thruster0 frame expressed
% in the onshape frame.
geo.Ro2t0o = geo.RTo0;

% Direction of each thruster in the Onshape reference frame
%{
Note, the direction here describes the direction of the thrusters "front"
or nose cone, NOT the direction of force when a PWM > 1500 is applied. An
additional mask is applied in the wrench_calculations.m script to account
for the different rotation direction of the thrusters that leads to this
difference. 
%}
geo.NTo0 = [0, 0, 1]';
geo.NTo1 = [0, 0, 1]';
geo.NTo2 = [0, 0, 1]';
geo.NTo3 = [0, 0, 1]';
geo.NTo4 = (sqrt(2)/2)*[1, -1, 0]';
geo.NTo5 = (sqrt(2)/2)*[1, 1, 0]';
geo.NTo6 = (sqrt(2)/2)*[1, 1, 0]';
geo.NTo7 = (sqrt(2)/2)*[1, -1, 0]';

geo.NTo = [geo.NTo0, geo.NTo1, geo.NTo2, geo.NTo3, geo.NTo4, geo.NTo5, geo.NTo6, geo.NTo7];

%mask with a + for all the thrusters where a positive force is reversed
%relative to their nominal pointing direction.
geo.NT_mask = [1, -1, 1, -1,-1,1,-1,1]';

%mass of each thruster in kg (does not account for distributed cord mass)
geo.mass_T = 0.383;


%% Cylinder
%Position of the geometric center of the cylinder in the onshape frame
geo.RCo = [0, 0, 0.111]'; %center
geo.length_C = 0.468;
geo.radius_C = 0.08;
geo.mass_C = 5.5;

%% DVL
geo.RDVLo = [0.114, 0, -0.055]';
geo.height_DVL = 0.017;
geo.radius_DVL = 0.033;
geo.mass_DVL = 0.105;
geo.Cbdvl = eye(3); %rotation matrix from dvl frame to body frame

%% Plate
geo.RPo = [0, 0, 0.00318]';
geo.length_P = 0.65;
geo.width_P = 0.549;
geo.height_P = 0.00635;
%add unaccounted for mass to plate
geo.mass_P = geo.m_total - 8*geo.mass_T - geo.mass_C - geo.mass_DVL;

%% Save
%refreshes the file path in case clear all was called
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

save(fullfile(prj_path_list.src_path,"scripts","Physical Parameter Calculations","physical_data.mat"),"geo",'-mat');