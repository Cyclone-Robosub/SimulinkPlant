function [command, current_command_index, current_command_status, time_in_current_command, this_command_start_time] = commandAdvancer(time, mission, current_command_index, current_command_status, time_in_current_command,this_command_start_time)

time_in_current_command = time - this_command_start_time; %update the timer for the active command

if(current_command_status == uint8('SUCC')) %if the last command was successful
    %advance
    current_command_index = current_command_index + 1;
    time_in_current_command = 0;
    this_command_start_time = time; %reset the timer for this command

elseif(current_command_status == uint8('RUNN') && time_in_current_command > mission{current_command_index}.timeout) %if the command time has expired
    %advance
    current_command_index = current_command_index + 1;
    time_in_current_command = 0;
    this_command_start_time = time; %reset the timer for this command

elseif(current_command_status == uint8('FAIL')) %if the last command failed
    %advance
    current_command_index = current_command_index + 1;
    time_in_current_command = 0;
    this_command_start_time = time; %reset the timer for this command

else %if the command is still running and has not succeeded or failed
    time_in_current_command = time - this_command_start_time;
     %send either the command or the idle command if none are left
    
end

%send out the command
%{
Note that each command is designed to be mostly stateless, the only
acception being hold-time within a tolerance. The low-level controller
watches for a reset pulse (triggered by a falling edge on the
time_in_current_command) and resets the hold timer whenver it sees one. 
%}
if(current_command_index > length(mission))
    command = idle_command; %todo - define the idle command
else
    command = mission{current_command};
end

end