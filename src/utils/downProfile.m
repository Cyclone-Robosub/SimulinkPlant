function cmd = downProfile(t,I,T)
% Sets the thruster profile for the down maneuver.
% Which thrusters fire is determined in commandToPWM.
% Output is scaled by thruster force in thrusterMaskToForce

%This is the function you change to set the profile. 
% It should be normalized between -1 and 1.
% It may also be defined as a piecewise function.
f = sin(2*pi*t/T);

%scale by requested intensity
f = f*I;

%pack output
cmd = [7,f];
end