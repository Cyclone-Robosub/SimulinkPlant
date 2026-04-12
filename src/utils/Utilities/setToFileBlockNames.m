function setToFileBlockNames(sim_select, data_path)
%{
Sets all the To-File block names in the provided model. The function will
create a base file name based on the data and time the sim was ran and then
add the name of the variable in the to-workspace block to the base name to
create a unique file path for each block.

Inputs:
model_select - the name of the model being modified
data_folder - the name of the folder where the data files will be saved

%}

to_file_blocks = find_system(sim_select, ...
    'LookUnderMasks', 'all', ...
    'FollowLinks',    'on',  ...
    'BlockType',      'ToFile');

if isempty(to_file_blocks)
    return;
end

base_name = string(datetime('now','Format','uuuu_MM_dd_HH_mm_ss'));
base_path = fullfile(data_path, base_name);
if(~isfolder(base_path))
    mkdir(base_path);
end

for i = 1:numel(to_file_blocks)
    var_name  = get_param(to_file_blocks{i}, 'MatrixName');
    new_name  = fullfile(base_path,var_name+".mat");

    set_param(to_file_blocks{i}, 'Filename', new_name);
    
end

end