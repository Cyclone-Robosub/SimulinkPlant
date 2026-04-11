function countLOC(targetDir)

    if(nargin < 1)
        targetDir = pwd;
    end

    mFiles = dir(fullfile(targetDir,'**','*.m'));
    
    l   = 0;
    loc = 0;
    
    % For all files
    for i = 1:numel(mFiles)
        fid = fopen(mFiles(i).name);
        
        lines = textscan(fid, '%s', 'Delimiter', '\n');
        lines = strtrim(lines{1});
        
        l   = l + numel(lines);
        loc = loc + sum(cellfun(...
            @(line) ~isempty(line) && line(1) ~= '%', lines));
        
        fclose(fid);
    end%for i
    
    fprintf('Lines of Code (LOC): %d / %d\n', loc, l);
    
end%function