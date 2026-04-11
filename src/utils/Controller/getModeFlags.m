function [do_PID_flag,do_FF_flag] = getModeFlags(mode_id)
%{
This function inputs the command structure and sends a flag to remove the
contribution of the feedforward controller or the PID controller depending
on the mode.
%}

switch mode_id
    case 0 %off
        do_PID_flag = 0;
        do_FF_flag = 0; 
    case 1 %FF
        do_PID_flag = 0;
        do_FF_flag = 1;
    case 2 %PID
        do_PID_flag = 1;
        do_FF_flag = 0;
    otherwise
        do_PID_flag = 0;
        do_FF_flag = 0;
end



end