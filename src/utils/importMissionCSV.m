function mission_file = importMissionCSV(path)
%pause warnings due to empty columns
%read csv data into a table
data = readtable(path,'Delimiter',',');


%remove the header
mission_table = data{4:end,:};

%find the size
nrows = height(mission_table);
ncols = width(mission_table);

for k = 1:nrows
    for j = 1:ncols
        %replace empty values with zero
        if(isequal(mission_table{k,j},{''}))
            mission_table{k,j} = 0;
        else
            %case the entry in the cell to a double
            mission_table{k,j} = str2double(cell2mat(mission_table(k,j)));
            %replace NaN values with 0
            if(isnan(mission_table{k,j}))
                mission_table{k,j} = 0;
            end
        end
    end
end

%convert to matrix
mission_file = cell2mat(mission_table);
end