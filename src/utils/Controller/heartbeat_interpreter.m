

function is_disconnect_flag = heartbeat_interpreter(isNew_heartbeat,dt_control)
    
    persistent time_since_last_beat;
    
    if isempty(time_since_last_beat)
        time_since_last_beat = 0;
    end

    %If you get a heartbeat value, time_since_last_beat = 0
    if (~isNew_heartbeat)
        time_since_last_beat =  time_since_last_beat + dt_control;
    else
        time_since_last_beat = 0;
    end

    %Set manual control flag if time since last heartbeat is greater than 1
    if (time_since_last_beat > 1)
        is_disconnect_flag = true;
    else
        is_disconnect_flag = false;
    end 
end