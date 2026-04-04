function cmd_array = importMission(file_name)
    f = fopen(file_name,"r");
    MAX_CMDS = 64;
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
        split_line = strsplit(line, {','});
        cmd_id = strtrim(split_line{1});
        wp = str2num(split_line{2})'; %#ok<ST2NM>
        wp_mask = str2num(split_line{3})'; %#ok<ST2NM>
        wp_tol = str2num(split_line{4})'; %#ok<ST2NM>
        hold_time = str2num(split_line{5}); %#ok<ST2NM>
        obj_id = strtrim(split_line{6});
        conf = str2double(split_line{7});
        trick_id = strtrim(split_line{8});
        exec_timeout = str2num(split_line{9}); %#ok<ST2NM>
        %{
        Replace each cmd_id with the 16_char version
        %}
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
cmd_id = int8(cmd_id);

switch trick_id
    otherwise
            trick_id = '________________';
end
trick_id = int8(trick_id);

switch obj_id
    otherwise
            obj_id = '________________';
end
obj_id = int8(obj_id);
    
command_k = struct(f1,cmd_id, f2, wp, ...
    f3, wp_mask, f4, wp_tol, ...
    f5, hold_time, f6, obj_id, f7, conf,...
    f8, trick_id, f9, exec_timeout);
cmd_array(k) = command_k; %#ok<AGROW>
k = k+1;
line = fgetl(f);
end
fclose(f);

%% Pad to MAX_CMDS with idle commands
idle_cmd = struct(...
    f1, int8('idle____________'), ...
    f2, zeros(6,1), ...
    f3, zeros(6,1), ...
    f4, zeros(6,1), ...
    f5, 999, ...
    f6, int8('________________'), ...
    f7, 0.0, ...
    f8, int8('________________'), ...
    f9, 999);

for i = k:MAX_CMDS
    cmd_array(i) = idle_cmd;
end

cmd_array = cmd_array(:);
end