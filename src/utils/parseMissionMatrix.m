function [command, current_maneuver_index, this_maneuver_end_time] = parseMissionMatrix(mission_file,time,...
    current_maneuver_index,this_maneuver_end_time,overwrite_mission_file_wp_flag,state_overwrite,...
    overwrite_mission_file_mode_flag,mode_overwrite)


%This function uses the mission matrix to determine the robot command
%The command is then used by the controller
%command = [this_control_mode,this_maneuver_id,...
            %this_maneuver_duration,this_maneuver_intensity,state_target...
            % this_maneuver_time] 
% size(command) is 1x11, the extra time field is useful for FF control

%enforce mission file orientation
mission_file = mission_file(:).';
[nrows,~] = size(mission_file);

%lookup current maneuver on the list
if(current_maneuver_index <= nrows)
    if(overwrite_mission_file_mode_flag)
        this_control_mode = mode_overwrite;
        
    else
        this_control_mode = mission_file(current_maneuver_index,1);
    end

    this_maneuver_id = mission_file(current_maneuver_index,2);
    this_maneuver_duration = mission_file(current_maneuver_index,3);
    this_maneuver_intensity = mission_file(current_maneuver_index,4);

    %get the target states (zero if none specified)
    state_target = mission_file(current_maneuver_index,5:10);
    %if another maneuver just, prepare this upcoming maneuver's end time
    if(this_maneuver_end_time==-1)
        %set this maneuvers end time
        this_maneuver_end_time = time + this_maneuver_duration;
        this_maneuver_time = 0;
    %if in  the middle of the maneuver
    elseif(this_maneuver_end_time > time)
        %update the time that we have been in the maneuver for
        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
    else
        %the maneuver timer has expired
        %advance the index, indicate you just ended, reset vars
        current_maneuver_index = current_maneuver_index+1;
        this_maneuver_time = this_maneuver_end_time;
        this_maneuver_end_time=-1;
        
    end
    %overwrite the wp from the file with the user input if desired
    if(overwrite_mission_file_wp_flag)
        state_overwrite = state_overwrite(:)';
        state_target = state_overwrite;
    end
    %send the command 
    command = [this_control_mode,this_maneuver_id,...
            this_maneuver_duration,this_maneuver_intensity,state_target,...
            this_maneuver_time];
    
else
    %if the time in the file has elapsed, do nothing
    command = zeros(1,11); 
end
