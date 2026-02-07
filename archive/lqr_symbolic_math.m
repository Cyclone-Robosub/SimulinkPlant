%% Symbolic Variables
%{
First define the dynamics symbolically and linearize them in terms of the
physical states X = [x y z dx dy dz phi theta psi wx wy wz] to find A and
B. 

Next, evaluate A and B at the reference values for each state. 
%}
%define symbolic variables for state vector
syms x xr y yr z zr real
x_error = x - xr;
y_error = y - yr;
z_error = z - zr;
syms dx dxr dy dyr dz dzr real %inertial velocity
dx_error = dx - dxr;
dy_error = dy - dyr;
dz_error = dz - dzr;
syms phi theta psi phir thetar psir real %euler angles
phi_error = phi - phir;
theta_error = theta - thetar;
psi_error = psi - psir;
syms wx wy wz wxr wyr wzr real %angular velocity
wx_error = wx - wxr;
wy_error = wy - wyr;
wz_error = wz - wzr;

%physical vectors
Ri = [x;y;z];
dRi = [dx;dy;dz];
dRi_error = [dx_error;dy_error;dz_error];
w = [wx;wy;wz];
w_error = [wx_error;wy_error;wz_error];

%state vector
X = [x y z dx dy dz phi theta psi wx wy wz]';

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

rt1 = [rt1x rt1y rt1z]';
rt2 = [rt2x rt2y rt2z]';
rt3 = [rt3x rt3y rt3z]';
rt4 = [rt4x rt4y rt4z]';
rt5 = [rt5x rt5y rt5z]';
rt6 = [rt6x rt6y rt6z]';
rt7 = [rt7x rt7y rt7z]';
rt8 = [rt8x rt8y rt8z]';

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

%% Forces and Torques
%drag
Fd = DF*(sign(dRb).*dRb.^2);
Td = DT*(sign(w).*w.^2);

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
dX(1:3) = dRi_error;
dX(4:6) = inv(M)*(FT + Fd + Fg + Fb);
dX(7:9) = w_error;
dX(10:12) = inv(I)*(TT + Td + Tb - vectorCross(w)*I*w);

%% Find the Jacobian for Linearization
A = jacobian(dX,X);
B = jacobian(dX,U);

%% Define the reference trajectory
%xyz will be arbitrary by setting corresponding Q terms to zero
%dxdydz will be zero for stationkeeping
%phi,theta will be zero for stationkeeping
%psi will be arbitrary by setting corresponding Q terms to zero
%wxwywz will be zero for stationkeeping

Xr = zeros(12,1);
Ur = zeros(8,1);

A_sk = subs(A,[X;U],[Xr;Ur]);
B_sk = subs(B,[X;U], [Xr;Ur]);