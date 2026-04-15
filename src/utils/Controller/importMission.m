function cmd_array = importMission(file_name, max_commands_in_mission)
    f = fopen(file_name,"r");
    
%define the field names for the command structure
%these must exactly match the names and types in setup_cmd_bus.m
    f1 = 'cmd_id';
    f2 = 'wp';
    f3 = 'wp_mask';
    f4 = 'wp_tol';
    f5 = 'hold_time';
    f6 = 'obj_id';
    f7 = 'conf';
    f8 = 'trick_id';
    f9 = 'exec_timeout';
    k = 1;
    fgetl(f); %skip first line
    line = fgetl(f);
%loop until the end of the file is reached
while ischar(line)
    %break out of loop once the first empty line is reached
    if(isempty(line)) 
        break;
    end
    %split by commas
    split_line = strsplit(line, {','});

    %identifier for the command
    cmd_id = strtrim(split_line{1});
   
    %waypoint [6x1], angles wrapped to pi
    wp = str2num(split_line{2})'; %#ok<ST2NM>
    wp(4:6) = wrapToPi(wp(4:6)); 
    
    %waypoint mask [6x1]
    wp_mask = str2num(split_line{3})'; %#ok<ST2NM>

    %waypoint tolerance [6x1]
    wp_tol = str2num(split_line{4})'; %#ok<ST2NM>

    %hold time [1x1]
    hold_time = str2num(split_line{5}); %#ok<ST2NM>

    %object identifier
    obj_id = strtrim(split_line{6});

    %object identification figure of merit
    conf = str2double(split_line{7});

    %trick identifier for trick commands
    trick_id = strtrim(split_line{8});

    %timeout for discountExecutive

    exec_timeout = str2num(split_line{9}); %#ok<ST2NM>
    
    
    %replace the full cmd names with 16 char shorthands
    switch cmd_id
        case 'drive_to_world_waypoint'
            cmd_id = 'drv_to_world_wp_';
        case 'drive_to_world_waypoint_seeking'
            cmd_id = 'drv_to_wp_seek__';
        case 'idle'
            cmd_id = 'idle____________';
        case 'track_object_waypoint'
            cmd_id = 'track_obj_wp____';
        case 'duration_trick'
            cmd_id = 'duration_trick__';
        case 'distance_trick'
            cmd_id = 'distance_trick__';
        otherwise
            cmd_id = 'idle____________';
    end
    %cast the command id to an array of int8s for the cmd class
    cmd_id = int8(cmd_id);

    %TBA - perform a similar substitution for tricks
    switch trick_id
        case 'ff_forward'
            trick_id = 'FF_Forward_Trick';
        case 'ff_backward'
            trick_id = 'FF_Backward_Tric';
        case 'ff_up'
            trick_id = 'FF_Up_Trick_____';
        case 'ff_down'
            trick_id = 'FF_Down_Trick___';
        case 'ff_right'
            trick_id = 'FF_Left_Trick___';
        case 'ff_left'
            trick_id = 'FF_Right_Trick__';
        case 'ff_pitchUp'
            trick_id = 'FF_PitchUp_Trick';
        case 'ff_pitchDown'
            trick_id = 'FF_PitchDown_Tri';
        case 'ff_yawRight'
            trick_id = 'FF_YawRight_Tric';
        case 'ff_yawLeft'
            trick_id = 'FF_YawLeft_Trick';
        case 'ff_rollRight'
            trick_id = 'FF_RollRight_Tri';
        case 'ff_rollLeft'
            trick_id = 'FF_RollLeft_Tric';
        case 'stop'
            trick_id = 'FF_Stop_________';
        case 'barrel_roll'
            trick_id = 'Barrel_Roll_Tric';
        otherwise
            trick_id = '________________';
    end
    trick_id = int8(trick_id);

    %TBA - perform a similar substitution for objects
    switch obj_id
        otherwise
            obj_id = '________________';
    end
    obj_id = int8(obj_id);
    
    %pack the command struct - this must match EXACTLY the corresponding
    %bus that is set up in setup_cmd_bus.m!
    command_k = struct(f1,cmd_id, f2, wp, f3, wp_mask, f4, wp_tol, f5,...
        hold_time, f6, obj_id, f7, conf, f8, trick_id, f9, exec_timeout);

    %populate the command array with this command
    cmd_array(k) = command_k; %#ok<AGROW>

    %advance to the next spot in the cmd_array and get the next line
    k = k+1;
    line = fgetl(f);
end

fclose(f); %close the file

%{
The size of the cmd_array must be fixed to use with Simulink. The
discountExecutive block expects a variable called mission of size
max_cmd_in_mission, so we will pad whatever entries have not been
populated.
%}
idle_cmd = struct(...
    f1, int8('idle____________'), ...
    f2, zeros(6,1), ...
    f3, zeros(6,1), ...
    f4, zeros(6,1), ...
    f5, 999999999, ...
    f6, int8('________________'), ...
    f7, 0.0, ...
    f8, int8('________________'), ...
    f9, 999999999);

for i = k:max_commands_in_mission
    cmd_array(i) = idle_cmd;
end

%enforce the orientation
cmd_array = cmd_array(:);

end