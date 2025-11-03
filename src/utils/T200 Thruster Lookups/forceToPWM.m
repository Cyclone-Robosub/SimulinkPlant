function PWM = forceToPWM(force_input,voltage_input) %#codegen
    %{
        This function will fail if generated if it references file
        paths. To fix this, load pwm.mat and interp_function_PWMToForce.mat
        as shared constants for codegen using coder.load. It might be
        inefficient to do this here. Instead it might be better to do this
        in a startup file and make sure the variables can be accessed by
        this function still. -KJH
    %}
    
    %load data needed by the function (todo here)
    
    pwm = coder.load("pwm.mat",'pwm');
    pwm = pwm.pwm;
    interp_function_PWMToForce = coder.load("interp_function_PWMToForce.mat",'interp_function');
    interp_function_PWMToForce = interp_function_PWMToForce.interp_function;
    
    %calculate the closest PWM to the known voltage and desired force combo
    %this could be optimized by using lookups for pwms unique
    forces_at_this_voltage = interp_function_PWMToForce(pwm,voltage_input * ones(size(pwm)));
    [forces_unique,idx] = unique(forces_at_this_voltage,'stable'); %remove duplicate forces for interpolation
    %force uniqueness in case of noise flipping adjacent force ordering
    forces_unique = sort(forces_unique);
    pwms_unique = pwm(idx); %get corresponding pwms

    PWM = zeros(size(force_input));

    %for each pwm input
    for k = 1:length(force_input)
        %both forces and pwms will be strictly monotonic, so we can invert          
        PWM(k) = round(interp1(forces_unique,pwms_unique,force_input(k),'linear','extrap'));
    end
end