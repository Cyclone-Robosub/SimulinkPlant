function base_path = defaultToFileBlockNames(sim_select)
%{
Sets all the To-File block names in the provided model. The function will
create a base file name based on the data and time the sim was ran and then
add the name of the variable in the to-workspace block to the base name to
create a unique file path for each block.

Inputs:
model_select - the name of the model being modified
data_folder - the name of the folder where the data files will be saved

%}


if ~bdIsLoaded(sim_select)
    open_system(sim_select);
end

to_file_blocks = find_system(sim_select, ...
    'LookUnderMasks', 'all', ...
    'FollowLinks',    'on',  ...
    'MatchFilter', @Simulink.match.allVariants,...
    'BlockType',      'ToFile');


if isempty(to_file_blocks)
    return;
end


for i = 1:numel(to_file_blocks)

    set_param(to_file_blocks{i}, 'Filename', "default");
    
end

end