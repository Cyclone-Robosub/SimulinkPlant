function pwm_cmd_list = forceToPWMCalculator(force_list,voltage,force_table,voltage_list,pwm_list)
%{
This function figures out what pwm to send in order to get the appropriate
force at the current voltage.


%}
pwm_cmd_list = zeros(size(force_list));

for k = 1:length(force_list)
    force = force_list(k);

    if(abs(force)<1e-3)
        %if the force setting is very low, just set thruster to stop
        %condition
        pwm_cmd = 1500;
    else
        
        %find the closest voltage less than the input voltage
        [~,closest_index] = min(abs(voltage_list-voltage));
       
        %see if the closest_voltage is above or below the input voltage
        if(closest_index==1)
            %no need to do any interpolation, just take the first column for forces
            lower_voltage_index = 1;
            upper_voltage_index = 1;
    
        elseif(closest_index==length(voltage_list))
            %no need to do any interpolation, just take the last column for forces
            lower_voltage_index = length(voltage_list);
            upper_voltage_index = length(voltage_list);
        elseif(voltage_list(closest_index) < voltage)
            lower_voltage_index = closest_index;
            upper_voltage_index = closest_index+1;
        else
            upper_voltage_index = closest_index;
            lower_voltage_index = closest_index-1;
        end
        
        %average the force column between the two indices\
        if(upper_voltage_index == lower_voltage_index)
            force_column = force_table(lower_voltage_index);
        else
            force_column = force_table(:,lower_voltage_index) + (voltage-voltage_list(lower_voltage_index))*(force_table(:,upper_voltage_index)-force_table(:,lower_voltage_index))/(voltage_list(upper_voltage_index)-voltage_list(lower_voltage_index));
        end
    
        %find the force closest to the input force
        [~,closest_index] = min(abs(force_column-force));
        
        %see if the closest_force is above or below the input force
        if(closest_index==1)
            %no need to do any interpolation, just take the first column for forces
            lower_force_index = 1;
            upper_force_index = 1;
        elseif(closest_index==length(force_list))
            %no need to do any interpolation, just take the last column for forces
            lower_force_index = length(force_list);
            upper_force_index = length(force_list);
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
        else
            alpha = (force - force_column(upper_force_index))/(force_column(upper_force_index)-force_column(lower_force_index));
        end
    
        %find closest pwm to this force
        pwm_cmd = pwm_list(lower_force_index) + alpha*(pwm_list(upper_force_index)-pwm_list(lower_force_index));
        pwm_cmd = round(pwm_cmd); %round to the nearest integer
    end
    pwm_cmd_list(k) = pwm_cmd;
end
