function clearTemp()
%{
This is a housekeeping function to delete all folders in src/temp.

It works by switching to the temp directory, deleting all the files in it,
then switching back to the original directory.

This function is only designed to work if the user is above the
SimulinkPlant folder in the directory structure, within SimulinkPlant, or
within SimulinkPlants subfolders. If you try to call this from directories
parallel to SimulinkPlant this function will fail.
%}

origin_dir = pwd;
in_SimulinkPlant_flag = 0;
%if 'SimulinkPlant is a substring of parent, move up
while(~in_SimulinkPlant_flag)
    [parent,folder] = fileparts(pwd);
    if(contains(parent,'SimulinkPlant'))
        cd ..;
    elseif(isequal(folder,'SimulinkPlant'))
        in_SimulinkPlant_flag = true;
    else
        %search for the the folder with SimulinkPlant folder
        try
            target_dir = dir(fullfile(pwd,'**','SimulinkPlant'));
            cd(target_dir(1).folder);
            in_SimulinkPlant_flag = true;
        catch
            error("Attempting to call clearTemp from an invalid location. Knock it off.");
        end
    end
end

%we should now be within the SimulinkPlant folder
cd('src/temp'); %switch into the temp folder
temp_contents = dir(pwd);
temp_contents = temp_contents(~ismember({temp_contents.name},{'.','..'}));

if(numel(temp_contents)>0)
    for k = 1:numel(temp_contents)
        item_path = fullfile(pwd,temp_contents(k).name);
        if temp_contents(k).isdir
            rmdir(item_path,'s');
        else
            delete(item_path);
        end
    end
end
cd(origin_dir);
end