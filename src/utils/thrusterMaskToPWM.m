function PWM = thrusterMaskToPWM(thruster_mask)

%max thruster force is defined in constants.m

%create 8x1 vector of force commands for each thruster
thruster_forces = max_thruster_force*thruster_mask; 

%to do - map to pwm