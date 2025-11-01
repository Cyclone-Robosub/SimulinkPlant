%max thrust force
max_thruster_force = 40;

%thruster voltage
voltage = 14;

%Inertia Matrix TODO - Update this KJH
J = diag([0.2572,0.3723,0.3015]);

%mass TODO - Update this KJH
m = 10; %[kg]

%thruster pointing directions
NTb_upper = [zeros(4,1),zeros(4,1),-1*ones(4,1)]';
NTb_lower = sqrt(2)/2*[1 1 0;...
                        1 -1 0;...
                        1 -1 0;...
                        1 1 0]';
NTb = [NTb_upper,NTb_lower]';
FT_wrench = NTb';

% thruster coordinate reference (m)
xo = 25.4e-2;
xi = 18.3e-2;
yo = 20.3e-2;
yi = 12.2e-2;
ho = 0.95e-2;
hi = 9.2e-2;

%thruster position in body frame TODO - Update this KJH
R_tb = [xo -yo ho;...
        xo yo ho;...
       -xo -yo ho;...
       -xo yo ho;...
        xi -yi hi;...
        xi yi hi;...
       -xi -yi hi;...
       -xi yi hi]';

MT_wrench = zeros(3,8);
for k = 1:8
    MT_wrench(:,k) = cross(R_tb(:,k),NTb(k,:));
end

%load in the interp function for PWMToForce
file_info = dir(fullfile(pwd,'**','interp_function_PWMToForce.mat'));

%assemble file path
path = fullfile(file_info.folder,file_info.name);

[PWMgrid,voltagegrid,Forces] = loadThrusterData();
PWMToForce(1100,10,PWMgrid,voltagegrid,Forces)
