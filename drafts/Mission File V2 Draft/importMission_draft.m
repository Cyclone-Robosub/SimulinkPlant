mission_file = "mission_file_v2.txt";

mission = importMission(mission_file);

function command_list = importMission(file_name)
    f = fopen(file_name,"r");

    %read the first line of the file
    line = fgetl(f);
    identifiers = {};
    waypoint = {};
    waypoint_mask = {};
    waypoint_tolerance = {};
    hold_time = {};
    object_identifier = {};
    confidence = {};
    trick_identifier = {};
    timeout = {};
    command_list = {};

    k = 1;
    %loop until the end of the file is reached
    while ischar(line)
        line = fgetl(f);
        if(ischar(line)) 
            split_line = strsplit(line, {','});
            identifiers{k} = split_line{1};
            waypoint{k} = str2num(split_line{2});
            waypoint_mask{k} = str2num(split_line{3});
            waypoint_tolerance{k} = str2num(split_line{4});
            hold_time{k} = str2num(split_line{5});
            object_identifier{k} = split_line{6};
            confidence{k} = str2num(split_line{7});
            trick_identifier{k} = split_line{8};
            timeout{k} = str2num(split_line{9});

            command_list{k} = commandClass(identifiers{k}, waypoint{k}, waypoint_mask{k}, waypoint_tolerance{k}, hold_time{k}, object_identifier{k}, confidence{k}, trick_identifier{k}, timeout{k});

            k = k+1;
        else
            break
        end
    end
    
    
end