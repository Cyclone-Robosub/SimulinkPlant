function openDataFolder()
%refreshes the file path in case clear all was called
if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

%open prj_path_list.user_data_path in the file explorer for the OS
folderPath = char(prj_path_list.user_data_path);

if ~isfolder(folderPath)
    error('openDataFolder:invalidPath', 'Folder does not exist: %s', folderPath);
end

if ispc
    system(['explorer "' folderPath '"']);
elseif ismac
    system(['open "' folderPath '" &']);
elseif isunix
    system(['xdg-open "' folderPath '" &']);
else
    error('openDataFolder:unsupportedOS', 'Unsupported operating system.');
end
end