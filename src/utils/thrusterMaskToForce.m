function [thrust] = thrusterMaskToForce(thruster_mask,max_thruster_force) %#codegen

%create 8x1 vector of force commands for each thruster
thrust = max_thruster_force*thruster_mask; 


