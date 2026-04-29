function [cmd_status, hold_timer, X_u, hold_timer_start_time, debug] = ...
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
    case {'rsff_forward____', 'rsff_backward___', 'rsff_up_________',...
            'rsff_down_______', 'rsff_right______', 'rsff_left_______',...
            'rsff_pitchUp____', 'rsff_pitchDown__', 'rsff_yawRight___',...
            'rsff_yawLeft____', 'rsff_rollRight__', 'rsff_rollLeft___',...
            'rsff_stop_______'}

        X_u = zeros(13,1); %dummy value
        [cmd_status, hold_timer, hold_timer_start_time] =FFTimer(cmd, hold_timer_start_time, t); 
    case {'ssff_forward____', 'ssff_backward___', 'ssff_up_________',...
            'ssff_down_______', 'ssff_right______', 'ssff_left_______',...
            'ssff_pitchUp____', 'ssff_pitchDown__', 'ssff_yawRight___',...
            'ssff_yawLeft____', 'ssff_rollRight__', 'ssff_rollLeft___',...
            'ssff_stop_______'}
        %{
        Operation: Create persistent X_u based on the current state. Start
        a timer. Every timestep in the command modify one field of X_u
        based on X and which type of maneuver is selected. Guidance law
        should handle the rest, no need for injection.
        %}
        if(abs(hold_timer_start_time - t)<1e-3)
            %send an indicator to reset
            reset = true;
        else
            reset = false;
        end

        [cmd_status, hold_timer, hold_timer_start_time, X_u] = executeSSFFDurationTrick(cmd, X, hold_timer_start_time,...
            t, reset);

    % case 'barrel_roll_____'
    %     %Create a waypoint in front of robot
    %     Eul = X.Eul;
    %     yaw = Eul(3);
    %     Ri_u = X.Ri + (X.Cib)*[1;0;0];
    %     X_u = [Ri_u;eulToQuat([0;0;yaw]);zeros(3,1);zeros(3,1)];
    % 
    %     [cmd_status, hold_timer, hold_timer_start_time] =FFTimer(cmd, hold_timer_start_time, t); 

    otherwise
        %output failure if the trick_id is unknown
        cmd_status = int8('FAIL');
        hold_timer = 0;
        hold_timer_start_time = t; %for the next command
        X_u = zeros(13,1);

end

debug = X_u;

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

function [cmd_status, hold_timer, hold_timer_start_time, X_u] = executeSSFFDurationTrick(cmd, X, hold_timer_start_time,t, reset)
hold_timer = t - hold_timer_start_time;

persistent ssff_X_u %waypoint for this trick

if(isempty(ssff_X_u))
    %Create the starting waypoint wherever the robot currently is located
    %with a speed of zero at a roll and pitch of zero.
    Eul = X.Eul;
    yaw = Eul(3);
    Ri = X.Ri;
    ssff_X_u = [Ri;eulToQuat([0;0;yaw]);zeros(3,1);zeros(3,1)];
end

if(reset)
    %Create the starting waypoint wherever the robot currently is located
    %with a speed of zero at a roll and pitch of zero.
    Eul = X.Eul;
    yaw = Eul(3);
    Ri = X.Ri;
    ssff_X_u = [Ri;eulToQuat([0;0;yaw]);zeros(3,1);zeros(3,1)];
end

switch char(cmd.trick_id)
    case 'ssff_forward____'
        %set the position on the waypoint 1m in the body x-direction
        ssff_X_u(1:3) = X.Ri + (X.Cib)*[1;0;0];
    case 'ssff_backward___'
        ssff_X_u(1:3) = X.Ri + (X.Cib)*[-1;0;0];
    case 'ssff_right______'
        %set the position on the waypoint 1m in the body x-direction
        ssff_X_u(1:3) = X.Ri + (X.Cib)*[0;1;0];
    case 'ssff_left_______'
        ssff_X_u(1:3) = X.Ri + (X.Cib)*[0;-1;0];
    case 'ssff_up_________'
        ssff_X_u(1:3) = X.Ri + (X.Cib)*[0;0;-1];
    case 'ssff_down_______'
        ssff_X_u(1:3) = X.Ri + (X.Cib)*[0;0;1];
    case 'ssff_stop_______'
        %no modification
        ssff_X_u = ssff_X_u; 
    case 'ssff_yawRight___'
        ssff_q_u = ssff_X_u(4:7);
        ssff_eul_u = quatToEul(ssff_q_u);
        ssff_eul_u(3) = X.Eul(3) + pi/6;
        ssff_X_u(4:7) = eulToQuat(ssff_eul_u);
    case 'ssff_yawLeft____'
        ssff_q_u = ssff_X_u(4:7);
        ssff_eul_u = quatToEul(ssff_q_u);
        ssff_eul_u(3) = X.Eul(3) - pi/6;
        ssff_X_u(4:7) = eulToQuat(ssff_eul_u);
    case 'ssff_rollRight__'
        ssff_q_u = ssff_X_u(4:7);
        ssff_eul_u = quatToEul(ssff_q_u);
        ssff_eul_u(1) = X.Eul(1) + pi/6;
        ssff_X_u(4:7) = eulToQuat(ssff_eul_u);
    case 'ssff_rollLeft___'
        ssff_q_u = ssff_X_u(4:7);
        ssff_eul_u = quatToEul(ssff_q_u);
        ssff_eul_u(1) = X.Eul(1) - pi/6;
        ssff_X_u(4:7) = eulToQuat(ssff_eul_u);
    case 'ssff_pitchUp____'
        ssff_q_u = ssff_X_u(4:7);
        ssff_eul_u = quatToEul(ssff_q_u);
        ssff_eul_u(2) = X.Eul(2) + pi/6;
        ssff_X_u(4:7) = eulToQuat(ssff_eul_u);
    case 'ssff_pitchDown__'
        ssff_q_u = ssff_X_u(4:7);
        ssff_eul_u = quatToEul(ssff_q_u);
        ssff_eul_u(2) = X.Eul(2) - pi/6;
        ssff_X_u(4:7) = eulToQuat(ssff_eul_u);
end


%update the timer and return success when it elapses
if(hold_timer >= cmd.hold_time)
    cmd_status = int8('SUCC');
    hold_timer_start_time = t;
    Eul = X.Eul;
    yaw = Eul(3);
    Ri = X.Ri;
    ssff_X_u = [Ri;eulToQuat([0;0;yaw]);zeros(3,1);zeros(3,1)];
else
    cmd_status = int8('RUNN');
end

X_u = ssff_X_u;


end


end