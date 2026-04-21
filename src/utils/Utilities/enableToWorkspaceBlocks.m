function enableToWorkspaceBlocks(model_select)
%{
Enables all To Workspace blocks in a model including referenced models and
nested subsystems. Disable by setting 'Commented' to 'on' (or right-click
-> Comment) or running disableToWorkspaceBlocks()

Input:
  model_select - Name of the top-level Simulink model (must be loaded)

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
    set_param(blocks{i}, 'Commented', 'off');
end

end