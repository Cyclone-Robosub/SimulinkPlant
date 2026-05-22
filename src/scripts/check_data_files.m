if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

data_files_path = prj_path_list.user_data_path;
data_files = dir(data_files_path); 

for i = 1:length(data_files)
    data_file = data_files(i).name;
    pwms_file = fullfile(data_files_path,data_file,"pwms.mat");

    if ~isfile(pwms_file)
        disp(data_file)
    end
end