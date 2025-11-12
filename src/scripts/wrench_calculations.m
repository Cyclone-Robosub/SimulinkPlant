
R_o2tk = [Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8]; %converted to m

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

[FT_wrench,MT_wrench,invFT_wrench,invMT_wrench] = calculateWrenchMatrices(RT_list,NT_list);

%modified versions of the wrench matrices used for thruster commands
