function [FT_cmd_list] = FFCmdToForce2(FF_maneuver_data,max_thruster_force, defined_maneuvers) %#codegen
%{
This function uses the command forward, reverse, up, down, etc... to 
send commands corresponding to that maneuver to the right thrusters at 
the specified intensity.
%}
FT_cmd_list = zeros(8,1);


%unpack the command
id = FF_maneuver_data(1); %maneuver id
dur = FF_maneuver_data(2); %duration of this maneuver
int = FF_maneuver_data(3); %intensity of this maneuver
t = FF_maneuver_data(4); %time in this maneuver so far
%TODO: Use t and dur to allow time varying maneuver signals

%find the index of this maneuver ID
idx = 0;
idx_matches = find(id == defined_maneuvers(:,10),1);
if(~isempty(idx_matches))
    idx = idx_matches;
end

if(idx ~= 0) %if a match was found 
    %get the intensity that corresponds with this maneuver (multiplicative with
    %the mission file intensity)
    intensity_maneuver = defined_maneuvers(idx,9);
    intensity_total = intensity_maneuver*int;
    
    %set FT_list from the maneuver, scale by intensity and clip between max and
    %min
    FT_cmd_list = clamp(defined_maneuvers(idx,1:8).*intensity_total,-max_thruster_force,max_thruster_force);
    FT_cmd_list(:) = FT_cmd_list;
end

end