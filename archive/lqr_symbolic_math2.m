%% Position and Velocity
syms x y z dx dy dz xr yr zr dxr dyr dzr real
R = [x;y;z];
dR = [dx;dy;dz];
Rr = [xr;yr;zr];
dRr = [dxr;dyr;dzr];

%p for partial, where p<var> = <var> - <var>r
pR = R - Rr; %state 1:3
pdR = dR - dRr; %pstate 1:3

%% Attitude
syms phi theta psi real %euler angles


%% linear dynamics
syms m max may maz real
M = diag([m+max;m+may:m_maz]); %mass + added mass


F = FT_wrench*u + Fdrag + Fbuoy + Fgrav; %forces
FT_wrench = symbolicFT_wrench();

ddR = F/M;
ddRr = zeros(3,1); %set reference acceleration to zero
