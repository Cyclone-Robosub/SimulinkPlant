function [FT_cmd_list] = FFCmdToForce(FF_maneuver_data,max_thruster_force) %#codegen
%{
This function uses the command forward, reverse, up, down, etc... to 
send commands corresponding to that maneuver to the right thrusters at 
the specified intensity.

%}
%unpack the command
id = FF_maneuver_data(1); %maneuver id
dur = FF_maneuver_data(2); %duration of this maneuver
int = FF_maneuver_data(3); %intensity of this maneuver
t = FF_maneuver_data(4); %time in this maneuver so far
%TODO: Use t and dur to allow time varying maneuver signals
switch(id)
    case 2 %"+x"
        %{
        Tune the intensity of the pitch thrusters to cancel out the extra
        pitching moment due to the location of the forward and backward
        thrusters.
        %}
        pif = 0.2; %pitch intensity front thrusters
        pib = -0.2; %pitch intensity back thrusters
        thruster_mask = int*[pif pif pib pib 1 1 1 1]';
        %drive forward

    case 5 %"-x"
        thruster_mask = int*[0 0 0 0 -1 -1 -1 -1]';
        %drive backward
    case 4 %"-yaw"
        thruster_mask = int*[0 0 0 0 0 0 0 0]';
        %yaw ccw
    case 3 %"+yaw"
        thruster_mask = int*[0 0 0 0 1 -.93 1 -.93]';
        %yaw cw
    case 6 %"-z"
        thruster_mask = int*[1 1 1 1 0 0 0 0]';
        %go up
    case 7 %"+z"
        thruster_mask = int*[-1 -1 -1 -1 0 0 0 0]';
        %go down
    case 0
        thruster_mask = zeros(8,1);
    otherwise
        thruster_mask = zeros(8,1);
end

FT_cmd_list = thrusterMaskToForce(thruster_mask,max_thruster_force); 


end