function modified_FT_List = trickFTListModifier(cmd, FT_cmd_list, FF_maneuvers)

if(isequal(char(cmd.cmd_id),'duration_trick__'))
    switch char(cmd.trick_id)
        case 'FF_Forward_Trick'
            modified_FT_List = FF_maneuvers.forward;
        case 'FF_Backward_Tric'
            modified_FT_List = FF_maneuvers.backward;
        case 'FF_Up_Trick_____'
            modified_FT_List = FF_maneuvers.up;
        case 'FF_Down_Trick___'
            modified_FT_List = FF_maneuvers.down;
        case 'FF_Left_Trick___'
            modified_FT_List = FF_maneuvers.left;
        case 'FF_Right_Trick__'
            modified_FT_List = FF_maneuvers.right;
        case 'FF_PitchUp_Trick'
            modified_FT_List = FF_maneuvers.pitchUp;
        case 'FF_PitchDown_Tri'
            modified_FT_List = FF_maneuvers.pitchDown;
        case 'FF_YawRight_Tric'
            modified_FT_List = FF_maneuvers.yawRight;
        case 'FF_YawLeft_Trick'
            modified_FT_List = FF_maneuvers.yawLeft;
        case 'FF_RollRight_Tri'
            modified_FT_List = FF_maneuvers.rollRight;
        case 'FF_RollLeft_Tric'
            modified_FT_List = FF_maneuvers.rollLeft;
        case 'FF_Stop_________'
            modified_FT_List = zeros(8,1);
        otherwise
            modified_FT_List = zeros(8,1);
    end
else
    modified_FT_List = FT_cmd_list;
end


end

%{
{'FF_Forward_Trick', 'FF_Backward_Tric', 'FF_Up_Trick_____',...
            'FF_Down_Trick___', 'FF_Left_Trick___', 'FF_Right_Trick__',...
            'FF_PitchUp_Trick', 'FF_PitchDown_Tri', 'FF_YawRight_Tric',...
            'FF_YawLeft_Trick', 'FF_RollRight_Tri', 'FF_RollLeft_Tric'}
%}