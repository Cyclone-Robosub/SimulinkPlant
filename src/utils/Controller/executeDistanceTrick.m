function [cmd_status, hold_timer, X_u, hold_timer_start_time, cmd_specific_wp] = ...
            executeDistanceTrick(cmd, idle_wp, X, hold_timer_start_time, ...
            t, new_cmd_reset, cmd_specific_wp)

%% Trick Switch
switch char(cmd.trick_id)
    case {'drv_to_body_wp__'}
        %set target waypoint once
        if(new_cmd_reset)
            %target quat
            Eul_u = idle_wp(4:6).*(~cmd.wp_mask(4:6)) +...
                cmd.wp(4:6).*(cmd.wp_mask(4:6));

            %add body position and body relative waypoint to get the
            %waypoint in the world view
            cmd_specific_wp(1:3) = X.Ri + cmd.wp(1:3);
            cmd_specific_wp(4:6) = Eul_u;
        end

        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
        [cmd_status, hold_timer, hold_timer_start_time] = WpHoldTimer(cmd, hold_timer_start_time, t, X, X_u); 

    otherwise
        %output failure if the trick_id is unknown
        cmd_status = int8('FAIL');
        hold_timer = 0;
        hold_timer_start_time = t; %reset the hold timer for the next command
        
        X_u = zeros(13,1); %dummy value, will not be used
        cmd_specific_wp = idle_wp; %dummy value, will not be used


end

%% Helper Functions
function [cmd_status, hold_timer, hold_timer_start_time] = WpHoldTimer(cmd, hold_timer_start_time, t, X, X_u)
    
    %update the hold timer if we are at our waypoint
    if(withinWPTol(X,X_u, cmd))
        hold_timer = t - hold_timer_start_time;
    else
        %otherwise keep pushing the start time so the hold timer starts
        %small on the next timestep
        hold_timer_start_time = t;
        hold_timer = 0;
    end
    
    %update the timer and return success when it elapses
    if(hold_timer >= cmd.hold_time)
        cmd_status = int8('SUCC');
        hold_timer_start_time = t;
    else
        cmd_status = int8('RUNN');
    end

end

end