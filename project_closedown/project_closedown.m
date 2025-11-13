%{
This script is run whenever the project closes to clean up unneeded files.
%}
%load the file paths if the variable doesn't already exist
if(~exist("prj_path_list","var"))
    prj_path_list = getProjectPaths();
end

%clears src/temp directory
warningState = warning('off','all');
clearTemp();
warning(warningState);

fprintf("Goodbye.\n")