function prj_paths = getProjectPaths()
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
            error("Attempting to call getProjectPath from an invalid location. Knock it off.");
        end
    end
end

%we should now be within the SimulinkPlant folder
cd('project_startup'); %switch into the project_startup folder
temp = load('prj_path_list.mat');
prj_paths = temp.prj_path_list;

try
    cd(origin_dir);
catch
    warning("Original directory was missing or deleted. Leaving you here.")
end
end