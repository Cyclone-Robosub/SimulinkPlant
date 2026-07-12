function enableDebugDataStores(model_select)
%{
Comments out all data store memory blocks with the prefix "db" in the name.

Input:
  modelName - Name of the top-level Simulink model (must be loaded)

%}
if ~bdIsLoaded(model_select)
    open_system(model_select);
end
fprintf("Enabling debug publishers.\n")

blocks = find_system(model_select, ...
    'LookUnderMasks',      'all', ...
    'FollowLinks',         'on',  ...
    'IncludeCommented',  'on', ...
    'MatchFilter', @Simulink.match.allVariants,...
    'BlockType',           'DataStoreWrite');

if isempty(blocks)
    return;
end

for i = 1:numel(blocks)
    this_name = get_param(blocks{i},'DataStoreName');

    if(this_name(1:2)=='db')
        set_param(blocks{i}, 'Commented', 'off');
    end

end

end