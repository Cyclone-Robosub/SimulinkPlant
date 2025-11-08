function [FT_cmd_list] = commandToForce(command,max_thruster_force) %#codegen
%{
This function uses the command forward, reverse, up, down, etc... to 
send commands corresponding to that maneuver to the right thrusters at 
the specified intensity.

{1,0.5}
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
    case 3 %"+yaw"
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

FT_cmd_list = thrusterMaskToForce(thruster_mask,max_thruster_force); 


end