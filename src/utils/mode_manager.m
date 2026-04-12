%{
The goal of the Mode Manager is to handle user inputs from the gamepad and
switch the controller modes effecively.

If we so wish to we can also add more functionality with the limit being
the total number of mode inputs we have.
%}

function [do_joystick_flag_out] = mode_manager(mode_inputs)
    %x_button = mode_inputs(1);
    circ_button = mode_inputs(1);
    
    
    persistent do_joystick_flag;
    %persistent mission_file; 

    if isempty(do_joystick_flag) 
        do_joystick_flag = 0; 
    end

    if(circ_button == true && do_joystick_flag == 0)
        do_joystick_flag = 1;

    end

    if(circ_button == true && do_joystick_flag == 1)
        do_joystick_flag = 0;
    end

    %do nothing
    if(circ_button == false)
    end

    do_joystick_flag_out = do_joystick_flag;

end