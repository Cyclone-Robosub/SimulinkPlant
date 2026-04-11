function [command, current_maneuver_index, this_maneuver_end_time] = parseMissionMatrix(mission_file,time,...
    current_maneuver_index,this_maneuver_end_time)
%returns the robot command in the form 
%command = [mode, maneuver id, maneuver duration, maneuver intensity,
%position waypoint, angle waypoint]

%check the size of the mission file (this should be constant)
[N_ROWS,~] = size(mission_file); %expected 100 x 10

if(current_maneuver_index <= N_ROWS) %if the mission file isn't finished
    
    %figure out the duration of the current maneuver
    this_maneuver_duration = mission_file(current_maneuver_index,3);

    %if another maneuver just, prepare this upcoming maneuver's end time
    if(maneuverJustEnded())
        %send the command 
        this_maneuver_time = 0; %reset the stopwatch
        command = readCommand(current_maneuver_index);
        %set this maneuvers end based on the current time and duration
        this_maneuver_end_time = time + this_maneuver_duration;
    %if in  the middle of the maneuver
    elseif(stillInManeuver())
        %send the command 
        this_maneuver_time = time - (this_maneuver_end_time - this_maneuver_duration);
        command = readCommand(current_maneuver_index);
    else
        %send the command 
        this_maneuver_time = this_maneuver_duration;
        command = readCommand(current_maneuver_index);

        %the maneuver timer has expired
        %advance the index, indicate you just ended by setting 
        % his_maneuver_end_time to -1, reset vars
        current_maneuver_index = current_maneuver_index+1;
        this_maneuver_end_time=-1;

    end

else
    %if the time in the file has elapsed, do nothing
    command = zeros(1, 11);
end

%helper functions
function flag = maneuverJustEnded()
    flag = (this_maneuver_end_time==-1);
end
function flag = stillInManeuver()
    flag = (this_maneuver_end_time > time);
end

function cmd = readCommand(k)
    %returns the command for line k
    mode = mission_file(k,1);
    id = mission_file(k,2);
    dur = mission_file(k,3);
    int = mission_file(k,4);
    x = mission_file(k,5);
    y = mission_file(k,6);
    z = mission_file(k,7);
    roll = mission_file(k,8);
    pitch = mission_file(k,9);
    yaw = mission_file(k,10);
    cmd = [mode, id, dur, int, x, y, z, roll, pitch, yaw, this_maneuver_time];
end

end



