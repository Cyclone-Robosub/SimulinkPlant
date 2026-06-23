function showCameraFeed(model_select, flag)
%{
If the flag is true, enables Unreal Engine Cosimulation and video displays.
If the flag is false, disables Unreal Engine Cosimulation and downstream
vision processing functions.
%}
if ~bdIsLoaded(model_select)
    open_system(model_select);
end

try
    if(flag)
        set_param([char(model_select),'/Camera Model/Simulation 3D Scene Configuration'], 'EnableWindow', 'on')
        set_param([char(model_select),'/Camera Model/Left Camera'], 'openAtMdlStart', 'on')
        set_param([char(model_select),'/Camera Model/Right Camera'], 'openAtMdlStart', 'on')
    else
        set_param([char(model_select),'/Camera Model/Simulation 3D Scene Configuration'], 'EnableWindow', 'off')
        set_param([char(model_select),'/Camera Model/Left Camera'], 'openAtMdlStart', 'off')
        set_param([char(model_select),'/Camera Model/Right Camera'], 'openAtMdlStart', 'off')
    end
catch
    fprintf("showCameraFeed did not execute. Most likely because %s does not contain camera models.\n",model_select);

end