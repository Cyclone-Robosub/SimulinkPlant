function [command, current_command_index, this_command_start_time] = commandAdvancer(time, mission, current_command_index, current_command_status,this_command_start_time)

time_in_current_command = time - this_command_start_time; %update the timer for the active command

if(isequal(current_command_status, uint8('SUCC'))) %if the last command was successful
    %advance
    current_command_index = current_command_index + 1;
    this_command_start_time = time; %reset the timer for this command

elseif(isequal(current_command_status,uint8('RUNN')) && time_in_current_command > mission{current_command_index}.timeout) %if the command time has expired
    %advance
    current_command_index = current_command_index + 1;
    this_command_start_time = time; %reset the timer for this command

elseif(isequal(current_command_status, uint8('FAIL'))) %if the last command failed
    %advance
    current_command_index = current_command_index + 1;
    this_command_start_time = time; %reset the timer for this command

else %if the command is still running and has not succeeded or failed
    %do nothing
    
end

%send out the command
%{
Note that each command is designed to be mostly stateless, the only
acception being hold-time within a tolerance. The low-level controller
watches for a reset pulse (triggered by a falling edge on the
time_in_current_command) and resets the hold timer whenver it sees one. 
%}

command = mission(current_command_index);


end