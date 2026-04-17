function [cmd, mission_idx_out] = discountExecutive(t, cmd_status, mission, reset)
%{
This function uses the mission information, the clock time, and the status
reported by the low-level controller to determine which command to send to
the low-level controller at any given time.

Operation: Check the status of the current command - advance to next if the
status is SUCCESS or FAIL - do nothing if the status is RUNNING.

Check the status of the timeout - advance to next if the timeout has
elapsed - do nothing otherwise

If the end of the mission is reached, the discountExecutive continues
outputting whatever the last command on the list is.

Inputs: t (double) - the time since the start of the simulation in seconds
cmd_status (4x1 int8) - 4 character status cast to an int8. Valid options
are "SUCC", "FAIL", and "RUNN" for success, failure, and running.

mission (Nx1 struct) - the vector of commands output by importMission.m.
Each command in the mission follows the template defined by setup_cmd_bus.m

Commands are structures with the following fields: cmd.cmd_id cmd.wp
cmd.wp_mask cmd.hold_time cmd.obj_id cmd.conf cmd.trick_id cmd.exec_timeout

%}

%variables that persist between controller timesteps
persistent cmd_start_time
persistent mission_idx

%initial states for persistent variables
if isempty(cmd_start_time)
    cmd_start_time = t;
end
if isempty(mission_idx)
    mission_idx = 1;
end 

if(reset)
    cmd_start_time = t;
    mission_idx = 1;
end


%check the status
cmd_status = cmd_status(:)';

if(isequal(char(cmd_status), 'SUCC'))
    % If success is indicated, advance to the next command
    advanced = true;
    [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
        mission, t);

elseif(isequal(cmd_status, int8('FAIL')))
    % If failure is indicated, advance to the next command
    advanced = true;
    [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
        mission, t);

else
    %otherwise, do not advance
    advanced = false;
end %if


% if we did not advance due to success or failure, compare the time spent
% on this command so far to the executive timeout
if(~advanced)
    %update the value of the timer
    timer = t - cmd_start_time;
    
    %advance to next if the exec_timeout has been reached
    if((timer >= mission(mission_idx).exec_timeout))
        [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
            mission, t);
    end %if
end %if

%make sure the mission_idx remains in the valid range
mission_idx = max(1, min(mission_idx, numel(mission)));

%select the command
cmd = mission(mission_idx);

%output the mission_idx for debugging purposes
mission_idx_out = mission_idx;

%helper function advance_to_next
function [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
        mission, t)

        %incriment the index
        mission_idx = mission_idx + 1;

        %clamp to allowable range
        mission_idx = max(1, min(mission_idx, numel(mission)));

        %reset the cmd_start_time to the current time
        cmd_start_time = t;
   
end %advance_to_next

end %discountExecutive