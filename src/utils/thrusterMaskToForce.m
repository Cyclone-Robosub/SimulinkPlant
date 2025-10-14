function [PWM, thrust] = thrusterMaskToForce(thruster_mask,max_thruster_force) %#codegen

%max thruster force is defined in constants.m

%create 8x1 vector of force commands for each thruster
thrust = max_thruster_force*thruster_mask; 

%TO DO: Replace this with a voltage input instead of a constant
PWM = forceToPWM(thrust,14);

