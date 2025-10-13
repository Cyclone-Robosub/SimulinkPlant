function PWM = thrusterMaskToForce(thruster_mask,max_thruster_force)

%max thruster force is defined in constants.m

%create 8x1 vector of force commands for each thruster
thruster_forces = max_thruster_force*thruster_mask; 

%TO DO: Replace this with a voltage input instead of a constant
PWM = forceToPWM(thruster_forces,14);

%to do - map to pwm