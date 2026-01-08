function mission_file = importMissionCSV(path)

C = readcell(path);      % read everything as cells
C = C(5:end,:);     % skip first 4 lines: metadata + header

<<<<<<< HEAD
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
=======
[n,m] = size(C);
% convert empty or nonnumeric cells to zero
for k = 1:n
    for j = 1:m
        v = C{k,j};
        if isempty(v) || ismissing(v)
            C{k,j} = 0;
        elseif ischar(v) || isstring(v)
            x = str2double(v);
            if isnan(x)
                C{k,j} = 0;
            else
                C{k,j} = x;
            end
        end
        if isempty(val)
            val = 0;
        elseif ischar(val) || isstring(val)
            val = str2double(val);
        end
        mission_file(i,j) = val;
    end
end

mission_file = cell2mat(C);

end
