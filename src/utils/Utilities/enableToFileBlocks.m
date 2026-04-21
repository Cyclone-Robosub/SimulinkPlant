function enableToFileBlocks(model_select)
%{
Enables all To File blocks in a model including referenced models and
nested subsystems. Disable by setting 'Commented' to 'on' (or right-click
-> Comment) or running disableToFileBlocks()

Input:
  modelName - Name of the top-level Simulink model (must be loaded)

%}
blocks = find_system(model_select, ...
    'LookUnderMasks',      'all', ...
    'FollowLinks',         'on',  ...
    'IncludeCommented',  'on', ...
    'MatchFilter', @Simulink.match.allVariants,...
    'BlockType',           'ToFile');

if isempty(blocks)
    return;
end

for i = 1:numel(blocks)
    set_param(blocks{i}, 'Commented', 'off');
end

end