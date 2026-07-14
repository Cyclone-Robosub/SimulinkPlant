function [modified_FT_List, dropper_trigger] = trickFTListInjector(cmd, FT_cmd_list, FF_maneuvers, overwrite_FT_list_flag, FT_list_inject)

dropper_trigger = false;

if(isequal(char(cmd.cmd_id),'duration_trick__'))
    switch char(cmd.trick_id)
        case 'ff_forward______'
            modified_FT_List = FF_maneuvers.forward;
        case 'ff_backward_____'
            modified_FT_List = FF_maneuvers.backward;
        case 'ff_up___________'
            modified_FT_List = FF_maneuvers.up;
        case 'ff_down_________'
            modified_FT_List = FF_maneuvers.down;
        case 'ff_right________'
            modified_FT_List = FF_maneuvers.left;
        case 'ff_left_________'
            modified_FT_List = FF_maneuvers.right;
        case 'ff_pitchUp______'
            modified_FT_List = FF_maneuvers.pitchUp;
        case 'ff_pitchDown____'
            modified_FT_List = FF_maneuvers.pitchDown;
        case 'ff_yawRight_____'
            modified_FT_List = FF_maneuvers.yawRight;
        case 'ff_yawLeft______'
            modified_FT_List = FF_maneuvers.yawLeft;
        case 'ff_rollRight____'
            modified_FT_List = FF_maneuvers.rollRight;
        case 'ff_rollLeft_____'
            modified_FT_List = FF_maneuvers.rollLeft;
        case 'ff_stop_________'
            modified_FT_List = zeros(8,1);
        case 'dropper_________'
            modified_FT_List = zeros(8,1);
            dropper_trigger = true;
        otherwise
            modified_FT_List = FT_cmd_list;
    end
elseif(isequal(char(cmd.cmd_id),'idle____________'))
    modified_FT_List = zeros(8,1);
elseif(isequal(char(cmd.cmd_id),'drv_to_world_wp_'))
    modified_FT_List = FT_cmd_list;
elseif(isequal(char(cmd.cmd_id),'drv_to_wp_seek__'))
    modified_FT_List = FT_cmd_list;
elseif(isequal(char(cmd.cmd_id),'track_obj_wp____'))
    modified_FT_List = FT_cmd_list;
elseif(isequal(char(cmd.cmd_id),'distance_trick__'))
    modified_FT_List = FT_cmd_list;
else
    modified_FT_List = zeros(8,1);
end


if(overwrite_FT_list_flag)
    modified_FT_List = FT_list_inject;
end
modified_FT_List = modified_FT_List(:);
end

