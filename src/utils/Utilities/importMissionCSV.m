function mission_file = importMissionCSV(path)
%{
This function reads in the mission file for the Simulation and creates the
mission_file matrix that is used by the controller. To prevent issues with
Simulink CodeGen, the size of this matrix is fixed at compile time to be
MAX_LINES x N_COLS.
%}

N_COLS = 10; %number of fields expected in the mission file
MAX_LINES = 100; %max number of lines read from the mission file
mission_file = zeros(MAX_LINES,N_COLS); %preallocate with fixed size

%read all the lines
lines = readlines(path);

%remove the first 4 lines of meta data
lines = lines(5:end,:);
[n_rows,~] = size(lines);


%new array to hold split lines
temp = zeros([n_rows,N_COLS]);

temp_row_index = 1; %index to track which row of the temporary array is being filled
for k = 1:n_rows
    line = lines(k,:);
    split_line = split(line,",");
    %remove any rows with empty lines
    mask = ismember(split_line,"");
    if isequal(sum(mask),0)
        numbers = str2double(split_line)';
        temp(temp_row_index,:) = numbers;
        temp_row_index = temp_row_index + 1;
    else
        continue
    end
end

%copy temp into the pre-allocated matrix
rows_to_copy = min(size(temp,1), size(mission_file,1));
mission_file(1:rows_to_copy, :) = temp(1:rows_to_copy, :);


end
