function [cmd, mission_idx_out] = discountExecutive(t, cmd_status, mission)
    %#codegen
    
    %{
    This function uses the mission information, the clock time, and the 
    status reported by the low-level controller to determine which command \
    to send to the low-level controller at any given time. 
    
    Operation:
    Check the status of the current command
        - advance to next if the status is SUCCESS or FAIL
        - do nothing if the status is RUNNING
    Check the status of the timeout
        - advance to next if the timeout has elapsed
        - do nothing otherwise
    
    Inputs:
    t (double) - the time since the start of the simulation in seconds
    cmd_status (4x1 int8) - 4 character status cast to an int8. 
    Valid options are "SUCC", "FAIL", and "RUNN" for success, failure, and 
    running.
    mission (Nx1 struct) - the vector of commands output by 
    importMission.m. Each command in the mission follows the template 
    defined by setup_cmd_bus.m
    
    template_command = struct("cmd_id",int8('16characters____'),"wp",...
        zeros(6,1),"wp_mask",zeros(6,1),"wp_tol",zeros(6,1),"hold_time",...
        0,"obj_id",int8('16characters____'),"obj_conf",0,"trick_id",...
        int8('16characters____'),"timeout",0);
    %}
    
    %variables that persist between controller timesteps
    persistent cmd_start_time
    persistent mission_idx
    persistent idle_cmd

    %initial states for persistent variables
    if isempty(cmd_start_time)
        cmd_start_time = t;
    end
    if isempty(mission_idx)
        mission_idx = 1;
    end
    
    if isempty(idle_cmd)
        %make sure this always matches the structure of cmd_bus
        idle_cmd = struct("cmd_id",int8('idle____________'),"wp",...
        zeros(6,1),"wp_mask",zeros(6,1),"wp_tol",zeros(6,1),"hold_time"...
        ,999999,"obj_id",int8('n/a_____________'),"conf",0,...
        "trick_id",int8('n/a_____________'),"exec_timeout",999999);

        %{
        Setting the waypoint mask to all zeros means the low level
        controller will do nothing. In the future we might want to modify
        this to hold the last commanded position instead.
        %}
    end

    %check the status
    cmd_status = cmd_status(:)';
    if(isequal(cmd_status, int8('SUCC')))
        advanced = true;
        [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
            mission, t);
    elseif(isequal(cmd_status, int8('FAIL')))
        advanced = true;
        [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
            mission, t);
    else
        advanced = false;
        %do nothing
    end
    
    
    %if the status has not already caused us to advance, check the timer
    if(~advanced && ~isequal(mission_idx,0))
        %update the timer
        timer = t - cmd_start_time;
    
        if((timer >= mission(mission_idx).exec_timeout) && (mission_idx > 0))
            [mission_idx, cmd_start_time] = advance_to_next(mission_idx,...
                mission, t);
        else
            %do nothing
        end
    
    end

    if(mission_idx > 0 && mission_idx <= 64)
        cmd = mission(mission_idx);
    else
        cmd = idle_cmd;
    end

    mission_idx_out = mission_idx; %output for debugging

    %helper function advance_to_next
    function [mission_idx, cmd_start_time] =...
            advance_to_next(mission_idx, mission, t)
        %incriment the index if commands remain in the mission
        if(mission_idx < numel(mission))
            mission_idx = mission_idx + 1;
        else
            mission_idx = 0; %flags use of idle cmd
        end

        cmd_start_time = t;
    end




end