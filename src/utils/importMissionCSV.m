function mission_file = importMissionCSV(path)

C = readcell(path);      % read everything as cells
C = C(5:end,:);          % skip first 4 lines: metadata + header

% convert empty or nonnumeric cells to zero
for k = 1:size(C,1)
    for j = 1:size(C,2)
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
    end
end

mission_file = cell2mat(C);

end
