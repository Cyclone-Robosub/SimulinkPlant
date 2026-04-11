%{
The goal of the Mode Manager is to handle user inputs from the gamepad and
switch the controller modes effecively.

If we so wish to we can also add more functionality with the limit being
the total number of mode inputs we have.
%}

function [do_joystick, do_mission_file] = mode_manager(mode_inputs)
    %x_button = mode_inputs(1);
    circ_button = mode_inputs(4);
    
    persistent joystick;
    persistent mission_file; 
    
    do_joystick = joystick;

    if(circ_button == true && do_joystick == 0)
        
        do_joystick = 1;
        joystick = 1;

    end

    if(circ_button == true && do_joystick == 1)
        do_joystick = 0;
        joystick = 0;
    end

    %do nothing
    if(circ_button == false)
        do_joystick = do_joystick; 
        joystick = joystick;
    end

end