R_o2tk = [Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8]; %converted to m

%position of the thrusters relative to the center of mass
R_cm2tk = zeros(3,8);
for k = 1:8
    R_cm2tk(:,k) = R_cm2o + R_o2tk(:,k);
end
RT_list = R_cm2tk;
%thruster pointing directions (should be no need to update this)
NT_list = (1/sqrt(3)) * [ ...
     1 -1  1 -1  1 -1  1 -1;
    -1 -1  1  1 -1 -1  1  1;
    -1 -1 -1 -1  1  1  1  1 ];

[FT_wrench,MT_wrench,invFT_wrench,invMT_wrench] = calculateWrenchMatrices(RT_list,NT_list);