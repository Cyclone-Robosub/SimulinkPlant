function mission_file = importMissionCSV(path)

%read all the lines
lines = readlines(path);

%remove the first 4 lines of meta data
lines = lines(5:end,:);
[rows,~] = size(lines);


%new array to hold split lines
mission_file = [];


for k = 1:rows
    line = lines(k,:);
    split_line = split(line,",");
    %remove any rows with empty lines
    mask = ismember(split_line,"");
    if isequal(sum(mask),0)
        numbers = str2double(split_line)';
        mission_file = [mission_file;numbers];
    else
        continue
    end
end

%If the mission file only has 1 row, add a padding row
padding = zeros(1,10);
mission_file = [padding',mission_file']';

end
