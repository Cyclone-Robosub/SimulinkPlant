function [ddRi,dw] = dynamics(T,F,w,Cib,I,invM,invI)
%{
This function computes the accelerations ddR and dw given the torque and
force on the rigid body in addition to the inverse of the mass matrix invM 
and inverse of theinertia matrix invI, both precomputed for efficiency. 

Here the mass matrix M is a diagonal 3x3 matrix where each term is the mass
plus the hydrodyanmic added mass in that direction. I is the moment of
inertia matrix (not necessarily diagonal) with three aded mass terms along
the diagonal.

This formulation rduces complexity assuming the added mass matrix
is diagonal. This does not accurately capture effects such as added
inertia to rotation due to linear acceleration, but will hopefully be good enough.

The added mass and added inertia terms will be estimated then tuned using
experiement data.

To use this function without the hydrodynamic effects simply set the added
mass coefficients in the mass matrix to zero.

References
1. Newton's Second Law - Isaac Newton
2. Eqn 11.8 - Curtis Orbital Mechanics for Engineers 4e
3. Brutzman Ch. 6 

Changelog:
Created on Nov 4, 2025 -KJH
%}

%enforce column vectors
Tb = T(:);
Fb = F(:);
w = w(:);

%compute the angular velocity derivative
dw = invI*(Tb - vectorCross(w)*I*w); %Curtis Eqn 11.8

%compute the acceleration using inertial coordinates
Fi = Cib*Fb;
ddRi = invM*(Fi);



end