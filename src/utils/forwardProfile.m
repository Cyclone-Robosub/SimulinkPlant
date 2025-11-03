function cmd = forwardProfile(t,I,T)%#codegen
% Sets the thruster profile for the forward maneuver.
% Which thrusters fire is determined in commandToPWM.
% Output is scaled by thruster force in thrusterMaskToForce

%This is the function you change to set the profile. 
% It should be normalized between -1 and 1.
% It may also be defined as a piecewise function.

%for example
f = sin(2*pi*t/T);

%or for testing
f = 1;

%scale by requested intensity
f = f*I;

%pack output
cmd = [2,f];
end