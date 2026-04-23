function disableToWorkspaceBlocks(model_select)
%{
Disables all To Workspace blocks in a model including referenced models and
nested subsystems. Blocks remain in the model but do not execute during
simulation. Re-enable by setting 'Commented' to 'off' (or right-click ->
Uncomment) or running enableToWorkspaceBlocks()

Input:
  modelName - Name of the top-level Simulink model (must be loaded)

%}
blocks = find_system(model_select, ...
    'LookUnderMasks',      'all', ...
    'FollowLinks',         'on',  ...
    'IncludeCommented',  'on', ...
    'MatchFilter', @Simulink.match.allVariants,...
    'BlockType',           'ToWorkspace');

if isempty(blocks)
    return;
end

for i = 1:numel(blocks)
    set_param(blocks{i}, 'Commented', 'on');
end

end