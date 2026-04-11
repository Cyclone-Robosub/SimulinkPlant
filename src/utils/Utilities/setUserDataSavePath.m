function setUserDataSavePath(varargin)
%{
Helper function that the allows the user to configure the default file path 
used by various scripts that save data.
%}

% call getProjectPaths if it doesn't exist
if(~exist('prj_paths_list','var'))
    prj_path_list = getProjectPaths();
end

%if no path is provided, reset the path to the default, which is temps
if(nargin==0)
    path = prj_path_list.temp_path;
else
    path = string(varargin{1});
end

% modify the user_data_path to the input path
prj_path_list.user_data_path = path;

% see if the specified path already exists and create it if it does not
if(~isfolder(prj_path_list.user_data_path))
    mkdir(prj_path_list.user_data_path);
end

%re-save the prj_paths variable
save(fullfile(prj_path_list.startup_path,"prj_path_list.mat"),"prj_path_list",'-mat');

%print confirmation to user
fprintf("Set path for data outputs to ""%s""\n",prj_path_list.user_data_path);
fprintf("Run prj_path_list = getProjectPaths(); to make load the latest version in the workspace.\n\n");
end