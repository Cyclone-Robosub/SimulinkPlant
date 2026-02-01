function [FT_cmd_list] = FFCmdToForce2(FF_maneuver_data,max_thruster_force,masks, defined_maneuvers) %#codegen
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

%find the index of this maneuver ID
idx = find(id,defined_maneuvers(:,IDX_MANEUVER_ID));

%get the intensity that corresponds with this maneuver (multiplicative with
%the mission file intensity)
intensity_maneuver = defined_maneuvers(idx,IDX_MANEUVER_INT);
intensity_total = intensity_maneuver + int;

FT_cmd_list = defined_maneuvers(idx,IDX_FT_LIST_START:IDX_FT_LIST_START+7)*intensity_total;
FT_cmd_list = FT_cmd_list(:); %enforce column

end