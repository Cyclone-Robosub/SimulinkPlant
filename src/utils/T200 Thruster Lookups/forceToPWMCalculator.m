function pwms_int32 = forceToPWMCalculator(FT_cmd_list, target_voltage, cw_pwm, ccw_pwm, cw_force, ccw_force, voltage)
%{
This function figures out what pwm to send in order to get the appropriate
force at the current target_voltage.

Due to the different blade polarity, thrusters 0 2 4 6 (index 1 3 5 7) use
the cw lookups, while thrusters 1 3 5 7 (index 2 4 6 8) use the ccw
lookups.

%}

N_thrusters = 8;
pwms_int32 = int32(1500*ones(N_thrusters,1)); 
pwms = 1500*ones(N_thrusters,1,'double');

%loop through all the cw thrusters
for k = 1:2:N_thrusters
    
    force = double(FT_cmd_list(k)); %force we need the pwm for


    if(abs(force)<1e-3)
        %if the force setting is very low, just set thruster to stop
        %condition
        pwm_cmd = 1500;
    else
        %find the closest voltage less than the input target_voltage
        [~,closest_index] = min(abs(voltage-target_voltage));
       
        %see if the closest_voltage is above or below the input target_voltage
        if(closest_index==1)
            %no need to do any interpolation, just take the first column for forces
            lower_voltage_index = 1;
            upper_voltage_index = 1;
    
        elseif(closest_index==length(voltage))
            %no need to do any interpolation, just take the last column for forces
            lower_voltage_index = length(voltage);
            upper_voltage_index = length(voltage);

        elseif(voltage(closest_index) < target_voltage)
            lower_voltage_index = closest_index;
            upper_voltage_index = closest_index+1;

        else
            upper_voltage_index = closest_index;
            lower_voltage_index = closest_index-1;

        end
        
        %average the force column between the two indices
        if(upper_voltage_index == lower_voltage_index)
            force_column = cw_force(lower_voltage_index);

        else
            
            force_column = cw_force(:, lower_voltage_index) + (target_voltage-voltage(lower_voltage_index))*(cw_force(:,upper_voltage_index)-cw_force(:,lower_voltage_index))/(voltage(upper_voltage_index)-voltage(lower_voltage_index));
        end
    
        %find the force closest to the input force
        [~,closest_index] = min(abs(force_column-force));
        
        %see if the closest_force is above or below the input force
        if(closest_index==1)
            %no need to do any interpolation, just take the first column for forces
            lower_force_index = 1;
            upper_force_index = 1;
        elseif(closest_index==length(FT_cmd_list))
            %no need to do any interpolation, just take the last column for forces
            lower_force_index = length(FT_cmd_list);
            upper_force_index = length(FT_cmd_list);
        elseif(force_column(closest_index) < force)
            lower_force_index = closest_index;
            upper_force_index = closest_index+1;
        else
            upper_force_index = closest_index;
            lower_force_index = closest_index-1;
        end
        
        %compute scaling coefficient between neighboring forces
        if(lower_force_index == upper_force_index)
            alpha = 0;
        elseif(abs(force_column(upper_force_index)-force_column(lower_force_index))<1e-3)
            alpha = 0;
        else
            alpha = (force - force_column(upper_force_index))/(force_column(upper_force_index)-force_column(lower_force_index));
        end
    
        %find closest pwm to this force
        pwm_cmd = cw_pwm(lower_force_index) + alpha*(cw_pwm(upper_force_index)-cw_pwm(lower_force_index));
        pwm_cmd = round(pwm_cmd); %round to the nearest integer
    end
    pwms(k) = pwm_cmd;

end

%loop through all the ccw thrusters
for k = 2:2:N_thrusters
    force = double(FT_cmd_list(k)); %force we need the pwm for


    if(abs(force)<1e-3)
        %if the force setting is very low, just set thruster to stop
        %condition
        pwm_cmd = 1500;
    else
        %find the closest voltage less than the input target_voltage
        [~,closest_index] = min(abs(voltage-target_voltage));
       
        %see if the closest_voltage is above or below the input target_voltage
        if(closest_index==1)
            %no need to do any interpolation, just take the first column for forces
            lower_voltage_index = 1;
            upper_voltage_index = 1;
    
        elseif(closest_index==length(voltage))
            %no need to do any interpolation, just take the last column for forces
            lower_voltage_index = length(voltage);
            upper_voltage_index = length(voltage);

        elseif(voltage(closest_index) < target_voltage)
            lower_voltage_index = closest_index;
            upper_voltage_index = closest_index+1;

        else
            upper_voltage_index = closest_index;
            lower_voltage_index = closest_index-1;

        end
        
        %average the force column between the two indices
        if(upper_voltage_index == lower_voltage_index)
            force_column = ccw_force(lower_voltage_index);

        else
            force_column = ccw_force(:, lower_voltage_index) + (target_voltage-voltage(lower_voltage_index))*(ccw_force(:,upper_voltage_index)-ccw_force(:,lower_voltage_index))/(voltage(upper_voltage_index)-voltage(lower_voltage_index));
        end
    
        %find the force closest to the input force
        [~,closest_index] = min(abs(force_column-force));
        
        %see if the closest_force is above or below the input force
        if(closest_index==1)
            %no need to do any interpolation, just take the first column for forces
            lower_force_index = 1;
            upper_force_index = 1;
        elseif(closest_index==length(FT_cmd_list))
            %no need to do any interpolation, just take the last column for forces
            lower_force_index = length(FT_cmd_list);
            upper_force_index = length(FT_cmd_list);
        elseif(force_column(closest_index) < force)
            lower_force_index = closest_index;
            upper_force_index = closest_index+1;
        else
            upper_force_index = closest_index;
            lower_force_index = closest_index-1;
        end
        
        %compute scaling coefficient between neighboring forces
        if(lower_force_index == upper_force_index)
            alpha = 0;
        elseif(abs(force_column(upper_force_index)-force_column(lower_force_index))<1e-3)
            alpha = 0;
        else
            alpha = (force - force_column(upper_force_index))/(force_column(upper_force_index)-force_column(lower_force_index));
        end
    
        %find closest pwm to this force
        pwm_cmd = ccw_pwm(lower_force_index) + alpha*(ccw_pwm(upper_force_index)-ccw_pwm(lower_force_index));
        pwm_cmd = round(pwm_cmd); %round to the nearest integer
    end
    pwms(k) = pwm_cmd;

end

pwms_int32(:) = int32(pwms(:));
