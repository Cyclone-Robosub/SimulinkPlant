function stashASVFiles()

% Moves all .asv files in the SimulinkPlant project and subfolders
% into a dedicated autosave folder: SimulinkPlant/codegen/autosaves

    % call getProjectPaths if it was cleared from the workspace
    if(~exist('prj_paths','var'))
        prj_paths = getProjectPaths();
    end
    
    % Destination folder
    autosaves_folder = prj_paths.asv_path;
    if ~isfolder(autosaves_folder)
        mkdir(autosaves_folder);
    end
    
    % Find all .asv files recursively
    asv_files = dir(fullfile(prj_paths.root_path,'**','*.asv'));
    % Move each .asv file to the destination folder
    for k = 1:length(asv_files)
        this_asv = fullfile(asv_files(k).folder, asv_files(k).name);
        destination_path = fullfile(autosaves_folder, asv_files(k).name);
        
        % If file with same name exists at the destination, delete it      
        if exist(destination_path, 'file')
            delete(destination_path);
        end
        
        movefile(this_asv, destination_path);
    end
    
end
