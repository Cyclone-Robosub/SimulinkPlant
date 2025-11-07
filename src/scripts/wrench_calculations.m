%thruster positions from the solidworks origin
Rt1 = [9.95 8 -1.675]';
Rt2 = [9.95 -8 -1.675]';
Rt3 = [-9.95 8 -1.675]';
Rt4 = [-9.95 -8 -1.675]';
Rt5 = [7.03 -4.95 1.93]';
Rt6 = [7.03 4.95 1.93]';
Rt7 = [-8.3 3.7 1.93]';
Rt8 = [-8.3 -3.7 1.93]';

R_t_o = [Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8].*(2.54/100); %converted to m

%position of the onshape origin relative to the center of mass
R_o_cm = [0.0096;0.0210;-.0009];

%position of the thrusters relative to the center of mass
R_t_cm = zeros(3,8);
for k = 1:8
    R_t_cm(:,k) = R_o_cm + R_t_o(:,k);
end
RT_list = R_t_cm;
%thruster pointing directions (should be no need to update this)
NTb_upper = [zeros(4,1),zeros(4,1),-1*ones(4,1)]';
NTb_lower = sqrt(2)/2*[1 1 0;...
                        1 -1 0;...
                        1 -1 0;...
                        1 1 0]';
NT_list = [NTb_upper,NTb_lower];

[force_wrench,moment_wrench] = calculateWrenchMatrices(RT_list,NT_list);

