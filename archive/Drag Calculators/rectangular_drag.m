function [Cd,A] = rectangular_drag(b,d,l)
%{
Inputs
D is the height of the face perpendicular to the flow
b is the width of the face perpendicular to the flow
l is the length of the rectangular face parallel to the flow

Outputs
Cd is the dimensionless drag coefficient
A is the projected area

This
%}
A = b*d;
ratio = l/d;

ratio_vector = [0.1, 0.5, 0.65, 1, 2, 3];
Cd_vector = [1.9, 2.5, 2.9, 2.2, 1.6, 1.3];




end