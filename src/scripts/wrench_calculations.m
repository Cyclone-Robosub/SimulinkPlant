%define conversion factor from in to m
in2m = 2.54/100;

%thruster positions from the onshape origin
Rt1 = [9.95 8 -1.675]'*in2m;
Rt2 = [9.95 -8 -1.675]'*in2m;
Rt3 = [-9.95 8 -1.675]'*in2m;
Rt4 = [-9.95 -8 -1.675]'*in2m;
Rt5 = [7.03 -4.95 1.93]'*in2m;
Rt6 = [7.03 4.95 1.93]'*in2m;
Rt7 = [-8.3 3.7 1.93]'*in2m;
Rt8 = [-8.3 -3.7 1.93]'*in2m;

R_o2tk = [Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8]; %converted to m

%position of the onshape origin relative to the center of mass
R_cm2o = [0.005; 0; 0.0369];

%position of the thrusters relative to the center of mass
R_cm2tk = zeros(3,8);
for k = 1:8
    R_cm2tk(:,k) = R_cm2o + R_o2tk(:,k);
end
RT_list = R_cm2tk;
%thruster pointing directions (should be no need to update this)
NTb_upper = [zeros(4,1),zeros(4,1),-1*ones(4,1)]';
NTb_lower = sqrt(2)/2*[1 1 0;...
                        1 -1 0;...
                        1 -1 0;...
                        1 1 0]';
NT_list = [NTb_upper,NTb_lower];

[force_wrench,moment_wrench] = calculateWrenchMatrices(RT_list,NT_list);

