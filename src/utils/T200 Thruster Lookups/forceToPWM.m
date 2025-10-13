function PWM = forceToPWM(force_input,voltage_input)

    persistent interp_function_PWMToForce %this variable must be persistant to avoid recomputing the function every time
    persistent pwm

    if isempty(interp_function_PWMToForce) || isempty(pwm)
        %search for the function is nested folders
        file_info = dir(fullfile(pwd,'**','interp_function_PWMToForce.mat'));

        %assemble file path
        path = fullfile(file_info.folder,file_info.name);

        %load in pregenerated function
        interp_function_PWMToForce = load(path);
        interp_function_PWMToForce = interp_function_PWMToForce.interp_function;

        %load pwms
         %search for the function is nested folders
        file_info = dir(fullfile(pwd,'**','pwm.mat'));
        path = fullfile(file_info.folder,file_info.name);
        pwm = load(path).pwm;
    end

    %calculate the closest PWM to the known voltage and desired force combo
    %this could be optimized by using lookups for forces_at_this_voltage,
    %forces unique, and pwms unique
    forces_at_this_voltage = interp_function_PWMToForce(pwm,voltage_input * ones(size(pwm)));
    [forces_unique,idx] = unique(forces_at_this_voltage,'stable'); %remove duplicate forces for interpolation
    %force uniqueness in case of noise flipping adjacent force ordering
    forces_unique = sort(forces_unique);
    pwms_unique = pwm(idx); %get corresponding pwms

    PWM = zeros(size(force_input));

    %for each pwm input
    for k = 1:length(force_input)
        %both forces and pwms will be strictly monotonic, so we can invert          
        PWM(k) = round(interp1(forces_unique,pwms_unique,force_input(k),'linear',NaN));
    end
end