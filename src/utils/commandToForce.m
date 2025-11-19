function [FT_cmd_list] = commandToForce(command,max_thruster_force, yaw_thrusters) %#codegen
%{
This function uses the command forward, reverse, up, down, etc... to 
send commands corresponding to that maneuver to the right thrusters at 
the specified intensity.

%}
%unpack the command
type = command(1);
intensity = command(2);

t0 = yaw_thrusters(1);
t1 = yaw_thrusters(2);
t2 = yaw_thrusters(3);
t3 = yaw_thrusters(4);
t4 = yaw_thrusters(5);
t5 = yaw_thrusters(6);
t6 = yaw_thrusters(7);
t7 = yaw_thrusters(8);

switch(type)
    case 2 %"+x"
        %{
        Tune the intensity of the pitch thrusters to cancel out the extra
        pitching moment due to the location of the forward and backward
        thrusters.
        %}
        pif = 0.2; %pitch intensity front thrusters
        pib = -0.2; %pitch intensity back thrusters
        thruster_mask = intensity*[pif pif pib pib 1 1 1 1]';
        %drive forward

    case 5 %"-x"
        thruster_mask = intensity*[0 0 0 0 -1 -1 -1 -1]';
        %drive backward
    case 4 %"-yaw"
        thruster_mask = intensity*[0 0 0 0 -1 1 -1 1]';
        %yaw ccw
    case 3 %"+yaw"
        thruster_mask = intensity*[-0.01 -0.01 -0.01 -0.01 0.95 -0.88 0.94 -0.87]';
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