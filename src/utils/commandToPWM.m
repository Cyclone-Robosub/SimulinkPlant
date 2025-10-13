function PWM = commandToPWM(command,max_thruster_force)
%{
This function uses the command forward, reverse, up, down, etc... to 
send commands corresponding to that maneuver to the right thrusters at 
the specified intensity.

%}
%unpack the command
type = command(1);
intensity = command(2);

switch(type)
    case 2 %"+x"
        thruster_mask = intensity*[0 0 0 0 -1 -1 -1 -1]';
        %drive forward
    case 5 %"-x"
        thruster_mask = intensity*[0 0 0 0 1 1 1 1]';
        %drive backward
    case 4 %"-yaw"
        thruster_mask = intensity*[0 0 0 0 1 -1 1 -1]';
        %yaw ccw
    case 4 %"+yaw"
        thruster_mask = intensity*[0 0 0 0 -1 1 -1 1]';
        %yaw cw
    case 6 %"-z"
        thruster_mask = intensity*[1 1 1 1 0 0 0 0]';
        %go up
    case 7 %"+z"
        thruster_mask = intensity*[-1 -1 -1 -1 0 0 0 0]';
        %go down
    case 0
        thruster_mask = zeros(8,1);
    otherwise
        thruster_mask = zeros(8,1);
end

PWM = thrusterMaskToForce(thruster_mask,max_thruster_force); %see utils, TBA


end