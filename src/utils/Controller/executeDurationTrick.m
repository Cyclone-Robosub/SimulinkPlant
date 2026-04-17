function [cmd_status, hold_timer, X_u, hold_timer_start_time] = ...
            executeDurationTrick(cmd, idle_wp, X, hold_timer_start_time,...
            t)

%{
Switch based on the type of trick. FF tricks are the simplest because the
value they output for X_u does not matter. It will be overwritten by the
trickFTListModifier function in the Low-Level controller while the
duration trick command with a FF trick is active.
%}
%% Trick Switch
switch char(cmd.trick_id)
    case {'ff_forward______', 'ff_backward_____', 'ff_up___________',...
            'ff_down_________', 'ff_right________', 'ff_left_________',...
            'ff_pitchUp______', 'ff_pitchDown____', 'ff_yawRight_____',...
            'ff_yawLeft______', 'ff_rollRight____', 'ff_rollLeft_____',...
            'ff_stop_________'}

        X_u = zeros(13,1); %dummy value
        [cmd_status, hold_timer, hold_timer_start_time] =FFTimer(cmd, hold_timer_start_time, t); 

    otherwise
        %output failure if the trick_id is unknown
        cmd_status = int8('FAIL');
        hold_timer = 0;
        hold_timer_start_time = t; %for the next command
        X_u = zeros(13,1);

end

%% Helper Functions
function [cmd_status, hold_timer, hold_timer_start_time] = FFTimer(cmd, hold_timer_start_time, t)
hold_timer = t - hold_timer_start_time;

if(hold_timer >= cmd.hold_time)
    cmd_status = int8('SUCC');
    hold_timer_start_time = t;
else
    cmd_status = int8('RUNN');
end

end

end