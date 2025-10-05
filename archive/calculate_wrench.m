% thruster coordinate reference (m)
xo = 25.4e-2;
xi = 18.3e-2;
yo = 20.3e-2;
yi = 12.2e-2;
ho = 0.95e-2;
hi = 9.2e-2;

%thruster position in body frame
R_tb = [xo -yo ho;...
        xo yo ho;...
       -xo -yo ho;...
       -xo yo ho;...
        xi -yi hi;...
        xi yi hi;...
       -xi -yi hi;...
       -xi yi hi]';

%thruster direction vectors
sr2 = sqrt(2)/2;
t_b_top = [zeros(4,1),zeros(4,1),-1*ones(4,1)]';
t_b_bottom = sqrt(2)/2*[1 1 0;...
                        1 -1 0;...
                        1 -1 0;...
                        1 1 0]';
t_b = [t_b_top,t_b_bottom];

%thruster magnitudes
syms F1 F2 F3 F4 F5 F6 F7 F8 real
F = [F1 F2 F3 F4 F5 F6 F7 F8]';

T_b = zeros(3,1);

for i = 1:8
    T_b = T_b + cross(R_tb(:,i),F(i)*t_b(:,i));
end
T_b_lhs = T_b;
F_b_lhs = t_b*F;

syms Fx Fy Fz real
syms Tx Ty Tz real
F_b_rhs = [Fx;Fy;Fz];
T_b_rhs = [Tx;Ty;Tz];

eqn = [F_b_lhs == F_b_rhs;...
    T_b_lhs == T_b_rhs];

[w,~] = equationsToMatrix(eqn,F);


wrench = eval(w);
inverse_wrench = pinv(wrench);
save("geometry_properties.mat","wrench","inverse_wrench")

% %Individual Thruster Saturation Point
% F_max = 30; %[N]
% 
% max_roll_torque = norm(wrench*(F_max*[1 -1 1 -1 0 0 0 0]'));
% max_yaw_torque = norm(wrench*(F_max*[0 0 0 0 -1 1 -1 1]'));
% max_pitch_torque = norm(wrench*(F_max*[1 1 -1 -1 0 0 0 0]'));
% 
% max_forward_thrust = norm(wrench*(F_max*[0 0 0 0 1 1 1 1]'));
% max_sideways_thrust = norm(wrench*(F_max*[0 0 0 0 1 -1 -1 1]'));
% max_upward_force = norm(wrench*(F_max*[1 1 1 1 0 0 0 0]'));

max_xyz_force = 24;
max_roll_torque = 5;
max_pitch_torque = 5;
max_yaw_torque = 5;