function VX = vectorCross(V)
%{
This function returns the cross product operator matrix VX such that
cross(V,U) = VX*U. Reference: De Ruiter - Spacecraft Dynamics and Control

Changelog:
Created on Nov 4, 2025 -KJH
%}
arguments
    V (3,1) {mustBeNumeric}
end
VX = [0 -V(3) V(2);...
      V(3) 0 -V(1);...
      -V(2) V(1) 0];

end