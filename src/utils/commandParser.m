function [off_flag, do_FF_flag,do_FB_flag,FF_maneuver_data,X_u] = commandParser(command)
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
        do_FB_flag = false;
        do_JOY_flag = false;
        off_flag = 1;
    case 1 %FF
        do_FF_flag = true;
        do_FB_flag = false;
        do_JOY_flag = false;
        off_flag = 0;
    case 2 %FB
        do_FF_flag = false;
        do_FB_flag = true;
        do_JOY_flag = false;
        off_flag = 0;
    case 3 %JOY
        do_FF_flag = false;
        do_FB_flag = false;
        do_JOY_flag = true;
        off_flag = 0;
    otherwise
        do_FF_flag = false;
        do_FB_flag = false;
        do_JOY_flag = false;
        off_flag = 1;
end

maneuver_id = command(2); %which maneuver to do
maneuver_dur = command(3); %total duration of the maneuver
maneuver_int = command(4); %how intense is the maneuver
maneuver_t = command(11); %how long have you been in the maneuver
FF_maneuver_data = [maneuver_id,maneuver_dur,maneuver_int,maneuver_t];

%pid target state vector
pos_eul_target = command(5:10)';

%quaternion target
qib_u = eulToQuat(pos_eul_target(4:6)); %convert eul target to quats]

%pack into state vector with dRi_u and wb_u targets of zero
X_u = [pos_eul_target(1:3);qib_u;zeros(3,1);zeros(3,1)];



