function setUnrealScenePath(model_select)
%{
Sets the Unreal Scene Path in any Unreal Scene Configuration Blocks to 
<root>\DROP UCS PACKAGED BUILD HERE\EllingtonPoolSim.exe

%}

if ~bdIsLoaded(model_select)
    open_system(model_select);
end

prj_path_list = getProjectPaths();

try
    executable_path = fullfile(prj_path_list.root_path, ...
        "DROP UCS PACKAGED BUILD HERE", "EllingtonPoolSim.exe");
    
    % Find all Simulation 3D Scene Configuration blocks
    sceneBlocks = find_system(model_select, ...
        'MaskType', 'Simulation 3D Scene Configuration');
    
    % Set the executable path on each block found
    for i = 1:length(sceneBlocks)
        set_param(sceneBlocks{i}, 'ProjectFormat', 'Unreal Executable', 'ProjectName', executable_path);
    end
catch
    fprintf("setUnrealScenePath did not execute. Either %s contains no Unreal Scene Configuration\nBlocks or the Executable was not found.\n",model_select);

end