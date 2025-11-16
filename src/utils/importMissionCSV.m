function mission_file = importMissionCSV(path)
%pause warnings due to empty columns
%read csv data into a table
data = readtable(path,'Delimiter',',');


%remove the header
mission_table = data(4:end,:);
mission_table = table2cell(mission_table);

%find the size
nrows = height(mission_table);
ncols = width(mission_table);
mission_file = zeros(nrows,ncols);

for j = 1:ncols
    for i = 1:nrows
        val = mission_table{i,j};   
        if iscell(val)
            val = val{1};           
        end
        if isempty(val)
            val = 0;
        elseif ischar(val) || isstring(val)
            val = str2double(val);
        end
        mission_file(i,j) = val;
    end
end
