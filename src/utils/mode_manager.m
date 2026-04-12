%{
The goal of the Mode Manager is to handle user inputs from the gamepad and
switch the controller modes effecively.

If we so wish to we can also add more functionality with the limit being
the total number of mode inputs we have.
%}

function [do_joystick_flag_out, do_mission_file_flag_out]  = mode_manager(mode_inputs)
    %flag variables
    persistent joystick_flag;
    persistent prior_joystick_flag;

    persistent do_mission_file_flag;
    persistent prior_do_mission_file_flag;
    
    %Initialize cosntants
    if isempty(joystick_flag)
        joystick_flag = 1;
    end

    if isempty(prior_joystick_flag)
        prior_joystick_flag = 1;
    end

    if isempty(do_mission_file_flag)
        do_mission_file_flag = 0;
    end

    if isempty(prior_do_mission_file_flag)
        prior_do_mission_file_flag = 0;
    end

    %User Inputs
    cross_button = mode_inputs(1);
    circ_button = mode_inputs(4);

    %% Toggle Logic (Joystick, )

    if(circ_button == true && prior_joystick_flag == 0)
        joystick_flag = 1;
    end

    if(circ_button == true && prior_joystick_flag == 1)
        joystick_flag = 0;
    end

    %do nothing, keep prior
    if(circ_button == false)
        prior_joystick_flag = joystick_flag;
    end

    if(cross_button == true && prior_do_mission_file_flag == 0)
        do_mission_file_flag = 1;
    end

    if(circ_button == true && prior_do_mission_file_flag == 1)
        do_mission_file_flag = 0;
    end

    if(circ_button == false)
        prior_do_mission_file_flag = do_mission_file_flag;
    end

    do_joystick_flag_out = joystick_flag;

    do_mission_file_flag_out = do_mission_file_flag;
end