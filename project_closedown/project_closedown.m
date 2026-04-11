%{
This script is run whenever the project closes to clean up unneeded files.
%}
%load the file paths if the variable doesn't already exist
try
    if(~exist("prj_path_list","var"))
        prj_path_list = getProjectPaths();
    end
    
    %clears src/temp directory
    warningState = warning('off','all');
    stashASVFiles();
    clearTemp();
    warning(warningState); 

catch exception
    fprintf("Failed to stash asv files and clear temp.");
end

fprintf("Goodbye.\n")