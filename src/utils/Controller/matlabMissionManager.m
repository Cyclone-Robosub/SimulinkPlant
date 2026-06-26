function goal_msg = matlabMissionManager(go_signal_msg, mission, t, cmd_status)
%{
Inputs:
go_signal [SL_Bus_std_msgs_Bool]
    .data [1x1 bool]
mission [Nx1 cmd_bus]
    .cmd_id [1x16 int8]
    .wp [6x1 double]
    .wp_mask [6x1 double]
    .wp_tol [6x1 double]
    .hold_time [1x1 double]
    .obj_id [1x16 int8]
    .conf [1x1 double]
    .trick_id [1x16 int8]
    .exec_timeout [1x1 double]
t [1x1 double]

%}
%unpack inputs from ROS2 msgs
go_flag = go_signal_msg.data;

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


%{
The intended operation is that the cmd_start_time and mission_idx reset
continuously whenver the go_switch is disabled. This makes it so as soon as
the go flag is true, the mission starts at the beginning.
%}
reset = ~go_flag;
if(reset)
    cmd_start_time = t;
    mission_idx = 1;
end

%translate the result msg

if(go_flag)
    %normal operation here
    %check the status
    cmd_status = cmd_status(:)';
    
    if(isequal(char(cmd_status), 'SUCC'))
        % If success is indicated, advance to the next command
        advanced = true;
        [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
            mission, t);
    
    elseif(isequal(cmd_status, int8('FAIL')))
        % If failure is indicated, advance to the next command
        % TODO - replace this with a transition to the fallback mission
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
            advanced = true;
        end %if
    end %if
    
    %make sure the mission_idx remains in the valid range
    mission_idx = max(1, min(mission_idx, numel(mission)));
    %select the command
    cmd = mission(mission_idx);
    
    %output the mission_idx for debugging purposes
    mission_idx_out = mission_idx;
    
    %check the conditions on start_new_cmd_flag (for debugging)
    if(advanced)
        start_new_cmd_flag = true;
    elseif(reset)
        start_new_cmd_flag = true;
    elseif(t <= 0.01) %sim just started
        start_new_cmd_flag = true;
    else
        start_new_cmd_flag = false;
    end

else
    %output a ff_stop command to turn off the thrusters
    cmd = %TO DO
end

%translate the cmd_bus into a goal_msg
goal_msg = cmdBusToGoalMsg(cmd);

