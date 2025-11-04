function [force_wrench,moment_wrench,inv_force_wrench,inv_moment_wrench] = calculateWrenchMatrices(RT_list,NT_list)
%{
This function returns the wrench matrices such that FT =
force_wrench*fT_list and MT = moment_wrench*fT_list where fT_list is the
8x1 vector of forces delivered by the 8 thrusters. 

Inputs:
RT_list - a 3x8 matrix where each column at index k is the position vector
of thruster k with respect to the center of mass (not the center of
volume) expressed in body coordinates.
NT_list - a 3x8 matrix where each column at index k is the direction vector
of thruster k expressed in body coordinates. 

Outputs:
force_wrench, moment_wrench - the 3x8 wrench matrices satisfying the
properties described above. -+
inv_force_wrench,inv_moment_wrench - the Moore Penrose pseudoinverse of
force_wrench and moment_wrench respectively. 

Changelog:
11/3/25 - Created function. KJH
%}

%input validation
arguments
    RT_list (3,8) {mustBeNumeric}
    NT_list (3,8) {mustBeNumeric}
end

force_wrench = NT_list;

moment_wrench = zeros(3,8);
for k = 1:8
    moment_wrench(:,k) = cross(RT_list(:,k),NT_list(:,k));
end

%precompute pseudoinverses for efficiency
inv_force_wrench = pinv(force_wrench);
inv_moment_wrench = pinv(moment_wrench);