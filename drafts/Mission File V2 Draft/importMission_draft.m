mission_file = "mission_file_v2.txt";

mission = importMission(mission_file);

function command_list = importMission(file_name)
    f = fopen(file_name,"r");

    command_list = {};
    
    %define the field names for the command structure
    f1 = 'command_identifier';
    f2 = 'waypoint';
    f3 = 'waypoint_mask';
    f4 = 'waypoint_tolerances';
    f5 = 'hold_time';
    f6 = 'object_identifier';
    f7 = 'visual_confidence';
    f8 = 'trick_identifier';
    f9 = 'executive_timeout';

    k = 1;
    fgetl(f); %skip first line
    line = fgetl(f);
    %loop until the end of the file is reached
    while ischar(line)
        split_line = strsplit(line, {','});
        command_identifier = strtrim(split_line{1});
        waypoint = str2num(split_line{2})'; %#ok<ST2NM>
        waypoint_mask = str2num(split_line{3})'; %#ok<ST2NM>
        waypoint_tolerances = str2num(split_line{4})'; %#ok<ST2NM>
        hold_time = str2num(split_line{5}); %#ok<ST2NM>
        object_identifier = strtrim(split_line{6});
        visual_confidence = str2double(split_line{7});
        trick_identifier = strtrim(split_line{8});
        executive_timeout = str2num(split_line{9}); %#ok<ST2NM>

        command_k = struct(f1,command_identifier, f2, waypoint, ...
            f3, waypoint_mask, f4, waypoint_tolerances, ...
            f5, hold_time, f6, object_identifier, f7, visual_confidence,...
            f8, trick_identifier, f9, executive_timeout);
        
        command_list{k} = command_k; %#ok<AGROW>
        
        k = k+1;
        
        line = fgetl(f);
    end
    
    
end