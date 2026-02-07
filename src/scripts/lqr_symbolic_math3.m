clear all; clc;
%% Step 1: State Transition Function dX = f(X,U)
%states
syms xb yb zb dxb dyb dzb q0 q1 q2 q3 wbx wby wbz real
%position vector
Rb = [xb;yb;zb];
%velocity vector
dRb = [dxb;dyb;dzb];
%quaternion (q0 is scalar, q1:3 is the vector)
qv = [q1;q2;q3];
q = [q0;qv]; %qib
Cib = quatToRotm([q1 q2 q3 q0]);
Cbi = inv(Cib);
%angular velocity
wb = [wbx;wby;wbz];
X = [Rb;dRb;q;wb];

% vehicle body parameters
syms m max may maz Ixx Iyy Izz V Rcm2cvx Rcm2cvy Rcm2cvz real %ma* is added mass, I includes added intertia
%Rcm2cv is the vector from the center of mass to the center of volume
Rcm2cv_b = [Rcm2cvx; Rcm2cvy; Rcm2cvz];
I = diag([Ixx;Iyy;Izz]);
M = diag([m+max;m+may;m+maz]);
% physical constants
syms rho g real

% thruster parameters
syms n1x n1y n1z n2x n2y n2z n3x n3y n3z n4x n4y n4z n5x n5y n5z...
    n6x n6y n6z n7x n7y n7z n8x n8y n8z real
%thruster position vectors
syms rt1x rt1y rt1z rt2x rt2y rt2z rt3x rt3y rt3z rt4x rt4y rt4z...
    rt5x rt5y rt5z rt6x rt6y rt6z rt7x rt7y rt7z rt8x rt8y rt8z real

rt1 = [rt1x rt1y rt1z]';
rt2 = [rt2x rt2y rt2z]';
rt3 = [rt3x rt3y rt3z]';
rt4 = [rt4x rt4y rt4z]';
rt5 = [rt5x rt5y rt5z]';
rt6 = [rt6x rt6y rt6z]';
rt7 = [rt7x rt7y rt7z]';
rt8 = [rt8x rt8y rt8z]';

N1 = [n1x n1y n1z]';
N2 = [n2x n2y n2z]';
N3 = [n3x n3y n3z]';
N4 = [n4x n4y n4z]';
N5 = [n5x n5y n5z]';
N6 = [n6x n6y n6z]';
N7 = [n7x n7y n7z]';
N8 = [n8x n8y n8z]';

N = [N1 N2 N3 N4 N5 N6 N7 N8]; %[3x8]
syms u1 u2 u3 u4 u5 u6 u7 u8 real
%% Forces
%gravity
Figrav = [0;0;g]; %NED frame
Fbgrav = Cbi*Figrav;
Mbgrav = zeros(3,1);
%buoyancy
Fibuoy = -rho*V*[0;0;g];
Fbbuoy = Cbi*Fibuoy;
Mbbuoy = cross(Rcm2cv_b,Fbbuoy);
%drag
%drag matrix for force and torque (assumed diagonal)
syms Ddx Ddy Ddz Dwbx Dwby Dwbz
DF = diag([Ddx,Ddy,Ddz]);
DT = diag([Dwbx Dwby Dwbz]);
epsilon = 1e-5; %small parameter to prevent discontinutity from sign(dx)
Fbdrag = DF*[dxb*sqrt(dxb^2+epsilon);dyb*sqrt(dyb^2+epsilon);dzb*sqrt(dzb^2+epsilon)];
Mbdrag = DT*[wbx*sqrt(wbx^2+epsilon);wby*sqrt(wby^2+epsilon);wbz*sqrt(wbz^2+epsilon)];
U = [u1 u2 u3 u4 u5 u6 u7 u8]';
%thrusters
%intermediate matrices for calculating the torque from the thrusters
f = [N1*u1; N2*u2; N3*u3; N4*u4; N5*u5; N6*u6; N7*u7; N8*u8]; %[24x1]
S = [vectorCross(rt1) vectorCross(rt2) vectorCross(rt3)...
    vectorCross(rt4) vectorCross(rt5) vectorCross(rt6)...
    vectorCross(rt7) vectorCross(rt8)]; %[3x24]
%thrusters
FTb = N*U; %[3x8]*[8x1]
MTb = S*f; %[3x24]*[24x1]

%% Dynamics
%dX = f(x,u)
f123 = dRb;
f456 = inv(M)*(FTb + Fbdrag + Fbgrav + Fbbuoy);
f78910 = [-0.5*qv'*wb;0.5*(q0*eye(3)+vectorCross(qv))*wb];
f111213 = inv(I)*(MTb + Mbdrag + Mbgrav + Mbbuoy - vectorCross(wb)*I*wb);
f = [f123;f456;f78910;f111213];

%calculate the A matrix for the full 13x1 state
A = jacobian(f,X);
B = jacobian(f,U);

%replace the dqidot/dqj block with zeros
A(8:10,8:10) = zeros(3);

%replace the dqidot/dwj block with eye(3)
A(8:10,11:13) = eye(3);

%delete the quaternion scalar row for B
syms B_lqr [12 8] real
B_lqr(1:6,:) = B(1:6,:);
B_lqr(7:12,:) = B(8:13,:);


%chop off the quaternion scalar rows
syms A_lqr [12 12] real
A_lqr(1:6,1:6) = A(1:6,1:6);
A_lqr(1:6,7:12) = A(1:6,8:13);
A_lqr(7:12,1:6) = A(8:13,1:6);
A_lqr(7:12,7:12) = A(8:13,8:13);

%% Functions for LQR
lqr_A = matlabFunction(A_lqr,'Vars',[q0 q1 q2 q3 dxb dyb dzb wbx wby wbz Ixx Iyy Izz m max may maz Ddx Ddy Ddz Dwbx Dwby Dwbz Rcm2cvx Rcm2cvy Rcm2cvz V g rho]);
lqr_B = matlabFunction(B_lqr,'Vars',[N(:);U(:);Ixx;Iyy;Izz;m;max;may;maz;rt1;rt2;rt3;rt4;rt5;rt6;rt7;rt8]);

