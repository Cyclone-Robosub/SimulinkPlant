function sim_mat_path = crashProofDataSaving(model_select, path)
%{
This function sets the file location field of the To File block that saves
simulation data. 
%}
%create a unique file name
data_file_prefix = string(datetime('now','Format','uu-MM-dd HH-mm-ss'));
sim_file_path = fullfile(path,data_file_prefix);

if(~isfolder(sim_file_path))
    mkdir(sim_file_path);
end

sim_mat_path = fullfile(sim_file_path,"results.mat");



end