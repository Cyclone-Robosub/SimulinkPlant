%list of waypoints in the pool's reference frame (aligned coordinate frame)
file_name = "example_waypoints.txt";

if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

f = fopen(file_name,"r");

line = fgetl(f);

pos_array = [];
%loop until the end of the file is reached
while ischar(line)
    %break out of loop once the first empty line is reached
    if(isempty(line)) 
        break;
    end
    %split by commas
    split_line = strsplit(line, {','});

    %identifier for the command
    x = str2double(strtrim(split_line{1}));
    y = str2double(strtrim(split_line{2}));
    z = str2double(strtrim(split_line{3}));
   
    pos = [x y z];
    pos_array = [pos_array; pos];
   
    %advance to the next spot in the cmd_array and get the next line
    line = fgetl(f);
end

fclose(f); %close the file



