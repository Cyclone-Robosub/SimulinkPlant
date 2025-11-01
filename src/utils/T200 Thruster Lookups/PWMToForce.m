function force = PWMToForce(pwm_input,voltage_input,PWMgrid,voltagegrid,Forces)

   % GridVectors 1x2 cell containing 1x201 pwms and 1x6 voltage
   % Values 201x6 force columns for each voltage

   persistent func

   if isempty(func)
       
       %compute gridded interpolant function and store in func
       func = griddedInterpolant(PWMgrid,voltagegrid,Forces);

   end
   
   force = zeros(size(pwm_input));

   for k = 1:length(pwm_input)
       force(k) = func(pwm_input(k),voltage_input(k));

   end

   
    
end
