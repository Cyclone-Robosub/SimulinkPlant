function [cmd_status, hold_timer, X_u, hold_timer_start_time, cmd_specific_wp] = ...
            executeDurationTrick(cmd, idle_wp, X, hold_timer_start_time,...
            t, new_cmd_reset, cmd_specific_wp)

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

        X_u = zeros(13,1); %dummy value, will not be used
        [cmd_status, hold_timer, hold_timer_start_time] =FFTimer(cmd, hold_timer_start_time, t); 
        
        cmd_specific_wp = idle_wp; %dummy value, will not be used

    case {'rsff_forward____', 'rsff_backward___', 'rsff_up_________',...
            'rsff_down_______', 'rsff_right______', 'rsff_left_______',...
            'rsff_pitchUp____', 'rsff_pitchDown__', 'rsff_yawRight___',...
            'rsff_yawLeft____', 'rsff_rollRight__', 'rsff_rollLeft___',...
            'rsff_stop_______'}

        X_u = zeros(13,1); %dummy value

        [cmd_status, hold_timer, hold_timer_start_time] =FFTimer(cmd, hold_timer_start_time, t); 
        cmd_specific_wp = idle_wp; %dummy value, will not be used

    case {'ssff_forward____', 'ssff_backward___', 'ssff_up_________',...
            'ssff_down_______', 'ssff_right______', 'ssff_left_______',...
            'ssff_pitchUp____', 'ssff_pitchDown__', 'ssff_yawRight___',...
            'ssff_yawLeft____', 'ssff_rollRight__', 'ssff_rollLeft___',...
            'ssff_stop_______'}
      
        [cmd_status, hold_timer, hold_timer_start_time, X_u, cmd_specific_wp] = executeSSFFDurationTrick(cmd, X, hold_timer_start_time,...
            t, new_cmd_reset, cmd_specific_wp);
       

    otherwise
        %output failure if the trick_id is unknown
        cmd_status = int8('FAIL');
        hold_timer = 0;
        hold_timer_start_time = t; %reset the hold timer for the next command
        
        X_u = zeros(13,1); %dummy value, will not be used
        cmd_specific_wp = idle_wp; %dummy value, will not be used

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

function [cmd_status, hold_timer, hold_timer_start_time, X_u, cmd_specific_wp] = executeSSFFDurationTrick(cmd, X, hold_timer_start_time,t, new_cmd_reset, cmd_specific_wp)

hold_timer = t - hold_timer_start_time; %these are duration tricks, so update the hold timer


if(new_cmd_reset)
    %Create the starting waypoint wherever the robot currently is located
    %with a speed of zero at a roll and pitch of zero.
    Eul = X.Eul;
    yaw = Eul(3);
    Ri = X.Ri;
    cmd_specific_wp = [Ri;[0;0;yaw]];
    
end

switch char(cmd.trick_id)
    case 'ssff_forward____'
        %set the position on the waypoint 1m in the body x-direction
        if(new_cmd_reset)
            %only creates a far away position waypoint ONCE
            cmd_specific_wp(1:3) = X.Ri + (X.Cib)*[1000;0;0];
        end
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)]; 

    case 'ssff_backward___'
        %{
        Right now the guidance law will just cause the robot to turn 180
        then drive forward. Not sure the best way to fix this but low
        priority.
        %}
        if(new_cmd_reset)
            %only creates a far away position waypoint ONCE
            cmd_specific_wp(1:3) = X.Ri + (X.Cib)*[-1000;0;0];
        end
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)]; 

    case 'ssff_right______'
        %{
        Right now the guidance law will just cause the robot to turn 90
        then drive forward. Not sure the best way to fix this but low
        priority.
        %}
        if(new_cmd_reset)
            %only creates a far away position waypoint ONCE
            cmd_specific_wp(1:3) = X.Ri + (X.Cib)*[0;1000;0];
        end
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)]; 
    case 'ssff_left_______'
        %{
        Right now the guidance law will just cause the robot to turn 90
        then drive forward. Not sure the best way to fix this but low
        priority.
        %}
        if(new_cmd_reset)
            %only creates a far away position waypoint ONCE
            cmd_specific_wp(1:3) = X.Ri + (X.Cib)*[0;-1000;0];
        end
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    case 'ssff_up_________'
        if(new_cmd_reset)
            %only creates a far away position waypoint ONCE
            cmd_specific_wp(1:3) = X.Ri + (X.Cib)*[0;0;-1000];
        end
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)]; 
    case 'ssff_down_______'
        if(new_cmd_reset)
            %only creates a far away position waypoint ONCE
            cmd_specific_wp(1:3) = X.Ri + (X.Cib)*[0;0;1000];
        end
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)]; 
    case 'ssff_stop_______'
        %no modification, will just be the idle wp in practice
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    case 'ssff_yawRight___'
        %for turns we actually do want to update just the angle portion of
        %the cmd_specific_wp every time step
        Eul = X.Eul;
        yaw = Eul(3);
        cmd_specific_wp(6) = yaw + pi/6;
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];

    case 'ssff_yawLeft____'
        Eul = X.Eul;
        yaw = Eul(3);
        cmd_specific_wp(6) = yaw - pi/6;
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    case 'ssff_rollRight__'
        Eul = X.Eul;
        roll = Eul(1);
        cmd_specific_wp(6) = roll + pi/6;
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    case 'ssff_rollLeft___'
        Eul = X.Eul;
        roll = Eul(1);
        cmd_specific_wp(6) = roll - pi/6;
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    case 'ssff_pitchUp____'
        Eul = X.Eul;
        pitch = Eul(2);
        cmd_specific_wp(6) = pitch + pi/6;
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    case 'ssff_pitchDown__'
        Eul = X.Eul;
        pitch = Eul(2);
        cmd_specific_wp(6) = pitch - pi/6;
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
    otherwise
        X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
end

%update the timer and return success when it elapses
if(hold_timer >= cmd.hold_time)
    cmd_status = int8('SUCC');
    hold_timer_start_time = t;
    X_u = [cmd_specific_wp(1:3); eulToQuat(cmd_specific_wp(4:6)); zeros(3,1); zeros(3,1)];
else
    cmd_status = int8('RUNN');
end



end


end