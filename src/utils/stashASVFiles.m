function stashASVFiles()

fprintf("Stashing away .asv files to avoid clutter.\n")
% Moves all .asv files in the SimulinkPlant project and subfolders
% into a dedicated autosave folder: SimulinkPlant/codegen/autosaves
% Generative AI was used in the creation of this code.

    % call getProjectPaths if it doesn't exist
    if(~exist('prj_paths','var'))
        prj_paths = getProjectPaths();
    end
    
    % Destination folder
    autosaves_folder = fullfile(prj_paths.asv_path,'autosaves');
    if ~isfolder(autosaves_folder)
        mkdir(autosaves_folder);
    end
    
    % Find all .asv files recursively
    asvFiles = dir(fullfile(prj_paths.root_path,'**','*.asv'));
    
    % Move each .asv file to the destination folder
    for k = 1:length(asvFiles)
        this_asv = fullfile(asvFiles(k).folder, asvFiles(k).name);
        destination_path = fullfile(autosaves_folder, asvFiles(k).name);
        
        % If file with same name exists, add a number suffix
        [~, name, ext] = fileparts(destination_path);
        counter = 1;
        while exist(destination_path, 'file')
            destination_path = fullfile(autosaves_folder, sprintf('%s_%d%s', name, counter, ext));
            counter = counter + 1;
        end
        
        movefile(this_asv, destination_path);
    end
    
end
