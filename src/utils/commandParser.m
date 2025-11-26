function [do_JOY_flag,do_FF_flag,do_PID_flag,FF_maneuver_data,state_target] = commandParser(command)
%This function uses the command vector to determine the robot control mode
%and output the proper settings.
%command = [this_control_mode,this_maneuver_id,...
            %this_maneuver_duration,this_maneuver_intensity,state_target...
            % this_maneuver_time] 

%enforce command is a row
command = command(:);
command = command';
mode = command(1);
switch mode
    case 0 %control off
        do_FF_flag = false;
        do_PID_flag = false;
        do_JOY_flag = false;
    case 1 %FF
        do_FF_flag = true;
        do_PID_flag = false;
        do_JOY_flag = false;
    case 2 %PID
        do_FF_flag = false;
        do_PID_flag = true;
        do_JOY_flag = false;
    case 3 %JOY
        do_FF_flag = false;
        do_PID_flag = false;
        do_JOY_flag = true;
    otherwise
        do_FF_flag = false;
        do_PID_flag = false;
        do_JOY_flag = false;
end

maneuver_id = command(2); %which maneuver to do
maneuver_dur = command(3); %total duration of the maneuver
maneuver_int = command(4); %how intense is the maneuver
maneuver_t = command(11); %how long have you been in the maneuver
FF_maneuver_data = [maneuver_id,maneuver_dur,maneuver_int,maneuver_t];
%pid target state vector
state_target = command(5:10)';


