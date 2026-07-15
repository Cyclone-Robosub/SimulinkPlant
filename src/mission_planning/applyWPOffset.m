%list of waypoints in the pool's reference frame (aligned coordinate frame)
file_name = "example_waypoints.txt";

start_position = [0.5,6.35];
depth_target = -1;

if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

f = fopen(file_name,"r");

fgetl(f); %skip first line
line = fgetl(f);

pos_array = [];
label_array = {};
%loop until the end of the file is reached
k = 1;
while ischar(line)
    %break out of loop once the first empty line is reached
    if(isempty(line)) 
        break;
    end
    %split by commas
    split_line = strsplit(line, {','});

    %identifier for the command
    x = str2double(strtrim(split_line{1})) - start_position(1);
    y = str2double(strtrim(split_line{2})) - start_position(2);
    z = str2double(strtrim(split_line{3})) - depth_target;
   
    pos = [x y z];
    pos_array = [pos_array; pos];
    label_array{k} = split_line{4};
    k = k+1;
   
    %advance to the next spot in the cmd_array and get the next line
    line = fgetl(f);
end

fclose(f); %close the file

%pad with zeroes for roll, pitch, yaw
pad_array = zeros(size(pos_array));

wp_array = [pos_array, pad_array];

[rows, ~] = size(wp_array);

string_array = {};

for k = 1:rows
    string_row = string(wp_array(k,:));
    string_array{k} = string_row(1) + "," + string_row(2) + "," + string_row(3) + ","...
        + string_row(4) + "," + string_row(5) + "," + string_row(6) + "," + string(label_array{k});
    fprintf("%s\n",string_array{k});
end

