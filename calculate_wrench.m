% to do: link picture of model for reference

%{

This script inputs the coordinates of each thrust vector relative to the
body center of mass and the direction of each thrust vector in the body
coordinate frame and returns the wrench matrix W such that:
[Force;Torque] = W*[F1 F2 ... F8]' where F1 ... F8 are the force commands
of the individual thrusters.

%}
%%
% thruster coordinate reference (m)
xo = 25e-2;
xi = 15e-2;
yo = 22e-2;
yi = 12e-2;
ho = 1e-2;
hi = 9e-2;

%thruster position in body frame
R_tb = [xo -yo -ho;...
        xo yo -ho;...
       -xo -yo -ho;...
       -xo yo -ho;...
        xi -yi -hi;...
        xi yi -hi;...
       -xi -yi -hi;...
       -xi yi -hi]';

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