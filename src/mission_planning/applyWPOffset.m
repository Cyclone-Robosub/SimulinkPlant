%list of waypoints in the pool's reference frame (aligned coordinate frame)
measurement_list = "example_waypoints.txt";
translated_measurement_list = "translated_waypoint.txt";
template_xml = "template_xml.xml";
result_xml = "result_semifinal.xml";

start_position = [0.5,6.35];
common_depth_target = -1;

%% Read in Measurement List
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

f = fopen(measurement_list,"r");

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
    z = str2double(strtrim(split_line{3})) - common_depth_target;
   
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

f = fopen(translated_measurement_list,'w');
string_array = {};
for k = 1:rows
    string_row = string(wp_array(k,:));
    string_array{k} = string_row(1) + "," + string_row(2) + "," + string_row(3) + ","...
        + string_row(4) + "," + string_row(5) + "," + string_row(6) + "," + string(label_array{k});
    fprintf("%s\n",string_array{k});
    fwrite(f,sprintf("%s\n",string_array{k}));
end
fclose(f);

%% Manually Edit Depths and Add Any Needed Rise and Descend Waypoints

%% Add edited waypoints to the template xml

f_in = fopen(translated_measurement_list,"r");
line_index = 1;
f_temp = fopen(template_xml,"r");
f_out = fopen(result_xml,"w");

fgetl(f_temp); %skip first line
temp_line = fgetl(f_temp);
in_line = fgetl(f_in);

while(ischar(temp_line))
   if(contains(temp_line,"DriveToWorldWaypoint"))
        num_fields = 6;
        in_line
        parts = strsplit(in_line, ',');
        new_waypoint = strjoin(parts(1:num_fields), ',');
        
        updated_line = regexprep(temp_line, '(world_waypoint=")[^"]*(")', ['$1' new_waypoint '$2']);
        fwrite(f_out, updated_line);
        fwrite(f_out,newline);     
        in_line = fgetl(f_in);
    else
        fwrite(f_out,temp_line);
        fwrite(f_out,newline);
    end

    temp_line = fgetl(f_temp);
end


fclose(f_in);
fclose(f_temp);
% fclose(f_out);

