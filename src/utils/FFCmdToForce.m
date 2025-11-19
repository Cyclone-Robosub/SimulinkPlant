function [FT_cmd_list] = FFCmdToForce(FF_maneuver_data,max_thruster_force,masks) %#codegen
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
    case 1
        thruster_mask = masks(:,1);
    case 2
        thruster_mask = masks(:,2);
    case 3
        thruster_mask = masks(:,3);
    case 4
        thruster_mask = masks(:,4);
    case 5
        thruster_mask = masks(:,5);
    case 6
        thruster_mask = masks(:,6);
    case 7
        thruster_mask = masks(:,7);
    case 8
        thruster_mask = masks(:,8);
    case 9
        thruster_mask = masks(:,9);
    case 10 
        thruster_mask = masks(:,10);
    case 11
        thruster_mask = masks(:,11);
    case 12
        thruster_mask = masks(:,12);
    case 0
        thruster_mask = zeros(8,1);
    otherwise
        thruster_mask = zeros(8,1);
end

FT_cmd_list = thrusterMaskToForce(thruster_mask,max_thruster_force); 


end