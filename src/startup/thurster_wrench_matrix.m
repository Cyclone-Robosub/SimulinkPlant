%define the position vector of each thruster relative to the centroid
%below values are placeholders to be updated
RT0 = [1 0 0]';
RT1 = [0 1 0]';
RT2 = [0 0 1]';
RT3 = [1 1 0]';
RT4 = [0 1 1]';
RT5 = [1 0 1]';
RT6 = [1 1 1]';
RT7 = [-1 -1 -1]';

RTk_b = [RT0, RT1, RT2, RT3, RT4, RT5, RT6, RT7]; %3x8, m


%define the normalized pointing direction of each thruster in body coordinates
%below values are placeholders to be updated
NT0 = [1 0 0]';
NT1 = [1 0 0]';
NT2 = [1 0 0]';
NT3 = [1 0 0]';
NT4 = [1 0 0]';
NT5 = [1 0 0]';
NT6 = [1 0 0]';
NT7 = [1 0 0]';
NTk_b = [NT0, NT1, NT2, NT3, NT4, NT5, NT6, NT7]; %3x8, dimensionless


%calculate the force wrench
force_wrench = NTk_b; %assumes NTk_b is normalized

%calculate the torque wrench
torque_wrench = zeros(3,8);
for k = 1:8
    torque_wrench(:,k) = cross(RTk_b(:,k), NTk_b(:,k));
end

%clear unneeded variables
clear NT0 NT1 NT2 NT3 NT4 NT5 NT6 NT7 RT0 RT1 RT2 RT3 RT4 RT5 RT6 RT7 k