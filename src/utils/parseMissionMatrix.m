function [command, current_maneuver_index, this_maneuver_end_time] = parseMissionMatrix(mission_file,time,...
    current_maneuver_index,this_maneuver_end_time)
%This function uses the mission matrix to determine the robot command
%The command is then used by the controller
%command = [this_control_mode,this_maneuver_id,...
            %this_maneuver_duration,this_maneuver_intensity,state_target...
            % this_maneuver_time] 
% size(command) is 1x11, the extra time field is useful for FF control

%lookup current maneuver on the list
if(current_maneuver_index < length(mission_file))
    this_control_mode = mission_file(current_maneuver_index,1);
    this_maneuver_id = mission_file(current_maneuver_index,2);
    this_maneuver_duration = mission_file(current_maneuver_index,3);
    this_maneuver_intensity = mission_file(current_maneuver_index,4);

    %get the target states (zero if none specified)
    state_target = mission_file(current_maneuver_index,5:10);

    %if another maneuver just, prepare this upcoming maneuver's end time
    if(this_maneuver_end_time==-1)
        %set this maneuvers end time
        this_maneuver_end_time = time + this_maneuver_duration;
       
    %if in  the middle of the maneuver
    elseif(this_maneuver_end_time > time)
        %update the time that we have been in the maneuver for
        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
        %TODO also send this time in maneuver to the feedforward control
    else
        %the maneuver timer has expired
        %advance the index, indicate you just ended, reset vars
        current_maneuver_index = current_maneuver_index+1;
        this_maneuver_end_time=-1;
    end

    %send the command 
    command = [this_control_mode,this_maneuver_id,...
            this_maneuver_duration,this_maneuver_intensity,state_target,...
            this_maneuver_time];
else
    %if the time in the file has elapsed, do nothing
    command = zeros(11,1); 
end