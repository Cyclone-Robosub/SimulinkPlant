%% Symbolic Variables

%define symbolic variables for state vector
syms x_error y_error z_error real %inertial position
syms dx dy dz real %inertial velocity
syms phi theta psi delta_theta delta_phi delta_psi real %euler angles
syms w1 w2 w3 real %angular velocity
syms phi_ref theta_ref psi_ref real %euler targets

%vectors
Ri = [x_error y_error z_error]';
dRi = [dx dy dz]';
wb = [w1 w2 w3]';

%state vector
X = [x_error y_error z_error dx dy dz delta_phi delta_theta delta_psi w1 w2 w3]';

%symbolic input (8 thruster inputs)
syms u1 u2 u3 u4 u5 u6 u7 u8 real
U = [u1 u2 u3 u4 u5 u6 u7 u8]';

%thruster direction vectors
syms n1x n1y n1z n2x n2y n2z n3x n3y n3z n4x n4y n4z n5x n5y n5z...
    n6x n6y n6z n7x n7y n7z n8x n8y n8z real
N1 = [n1x n1y n1z]';
N2 = [n2x n2y n2z]';
N3 = [n3x n3y n3z]';
N4 = [n4x n4y n4z]';
N5 = [n5x n5y n5z]';
N6 = [n6x n6y n6z]';
N7 = [n7x n7y n7z]';
N8 = [n8x n8y n8z]';

N = [N1 N2 N3 N4 N5 N6 N7 N8]; %[3x8]

%thruster position vectors
syms rt1x rt1y rt1z rt2x rt2y rt2z rt3x rt3y rt3z rt4x rt4y rt4z...
    rt5x rt5y rt5z rt6x rt6y rt6z rt7x rt7y rt7z rt8x rt8y rt8z real

rt1 = [rt1x rt1y rt1z];
rt2 = [rt2x rt2y rt2z];
rt3 = [rt3x rt3y rt3z];
rt4 = [rt4x rt4y rt4z];
rt5 = [rt5x rt5y rt5z];
rt6 = [rt6x rt6y rt6z];
rt7 = [rt7x rt7y rt7z];
rt8 = [rt8x rt8y rt8z];

%intermediate matrices for calculating the torque from the thrusters
f = [N1*u1; N2*u2; N3*u3; N4*u4; N5*u5; N6*u6; N7*u7; N8*u8]; %[24x1]
S = [vectorCross(rt1) vectorCross(rt2) vectorCross(rt3)...
    vectorCross(rt4) vectorCross(rt5) vectorCross(rt6)...
    vectorCross(rt7) vectorCross(rt8)]; %[3x24]

%define vehicle parameters
syms m g real %gravity and total vehicle mass
syms max may maz real %added mass in the x, y, and z direction
syms Ix Iy Iz real %moment of inertia (including added mass)
syms V rho %displaced volume and density of water
syms Rcv1 Rcv2 Rcv3 %position of the center of volume from center of mass

%combined mass matrix
M = diag([m+max,m+may,m+maz]);
I = diag([Ix, Iy, Iz]);

Rcv = [Rcv1 Rcv2 Rcv3]';

%drag matrix for force and torque (assumed diagonal)
syms Ddx Ddy Ddz Dw1 Dw2 Dw3
DF = diag([Ddx,Ddy,Ddz]);
DT = diag([Dw1 Dw2 Dw3]);

%rotation matrix from body to inertial
Cib = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);
        sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), sin(phi)*cos(theta);
        cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi), cos(phi)*cos(theta)];
Cbi = Cib';
%gravity vector
gi = [0;0;g];
gb = Cbi*gi;

%velocity in body coordinates (for drag)
dRb = Cbi*dRi;

%reference rate for trim state
syms pref qref rref real
wref = [pref qref rref]';

%% Forces and Torques
%drag
Fd = DF*(sign(dRb).*dRb.^2);
Td = DT*(sign(wb).*wb.^2);

%gravity
Fg = m*gb;
Tg = zeros(3,1);

%buoyancy
Fb = -rho*V*gb;
Tb = -rho*V*vectorCross(Rcv)*gb;

%thrusters
FT = N*U; %[3x8]*[8x1]
TT = S*f; %[3x24]*[24x1]

%% Nonlinear State Transition Matrix
syms dX [12 1] real
dX(1:3) = dRi;
dX(4:6) = inv(M)*(FT + Fd + Fg + Fb);
dX(7:9) = wb - wref;
dX(10:12) = inv(I)*(TT + Td + Tb - vectorCross(wb)*I*wb);

%% Find the Jacobian for Linearization
A = jacobian(dX,X);
B = jacobian(dX,U);

%define trim state for easy substitution
trim.X = sym('X_trim',[12 1]);
trim.U = sym('U_trim',[8 1]);

% Evaluate at a trim
A_trim = subs(A, [X;U], [trim.X;trim.U]);
B_trim = subs(B,[X;U], [trim.X;trim.U]);

%% Find lqr gain for various trim states
%stationkeeping
%{
To find K, use X_lqr as the full 12x1 state vector, and set the value of Q
to zero for the terms that do not need to be regulated.

For unregulated states, a reasonable arbitrary trim value can be plugged
into the A and B matrices
%}

R_trim = [0;0;0]; %arbitrary, unregulated for stationkeeping. In dynamics use current state
V_trim = [0;0;0]; %not arbitrary
Eul_trim = [0;0;0]; %yaw is arbitrary, unregulated for stationkeeping
w_trim = [0;0;0]; %not arbitrary

stationkeeping_X = [R_trim;V_trim;Eul_trim;w_trim];
stationkeeping_U = [0 0 0 0 0 0 0 0]'; %replace this with the u necessary to cancel gravity and buoyancy
Q = diag([1,2,3,4,5,6,7,8,9,10,11,12]); %to do
R = diag([1,2,3,4,5,6,7,8]);
A_stationkeeping = subs(A,[X;U],[stationkeeping_X;stationkeeping_U]);
B_stationkeeping = subs(B,[X;U],[stationkeeping_X;stationkeeping_U]);

%make sure to evaluate A and B numerically before calculating K
K_stationkeeping = lqr(A_stationkeeping,B_stationkeeping,Q,R);