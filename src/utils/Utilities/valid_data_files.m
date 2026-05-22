% Grabs all the data folders in the user data directory that have a pwms file
function valid_files = valid_data_files(data_files)

    if(~exist('prj_path_list','var')) 
        prj_path_list = getProjectPaths();
    end
    
    data_files_path = prj_path_list.user_data_path;
    valid_files = data_files([]);
    
    for i = 1:length(data_files)
        data_file = data_files(i).name;
        pwms_file = fullfile(data_files_path,data_file,"pwms.mat");
    
        if isfile(pwms_file)
            valid_files(end + 1) = data_files(i);
        end
    end
    
end