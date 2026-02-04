function output_path = prepareOutputFolder(prj_path_list)
    folder_name = string(datetime("now","Format","uuuu_MM_dd hh_mm_ss"));
    output_path = fullfile(prj_path_list.user_data_path,folder_name);
end