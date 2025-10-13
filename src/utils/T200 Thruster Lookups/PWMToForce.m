function force = PWMToForce(pwm_input,voltage_input)

    persistent interp_function_PWMToForce %this variable must be persistant to avoid recomputing the function every time

    if isempty(interp_function_PWMToForce)
        %search for the function is nested folders
        file_info = dir(fullfile(pwd,'**','interp_function_PWMToForce.mat'));

        %assemble file path
        path = fullfile(file_info.folder,file_info.name);

        %load in pregenerated function
        interp_function_PWMToForce = load(path);
        interp_function_PWMToForce = interp_function_PWMToForce.interp_function;
    end
    
    %evaluate for each input pwm
    force = zeros(size(pwm_input));
    for i = 1:length(pwm_input)
        force(i) = interp_function_PWMToForce(pwm_input(i),voltage_input);
    end
    force = force(:);
end

