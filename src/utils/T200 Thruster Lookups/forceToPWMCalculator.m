function pwms_int32 = forceToPWMCalculator(force_list,voltage,cw_ref,ccw_ref,voltage_list,pwm_list)
%{
This function figures out what pwm to send in order to get the appropriate
force at the current voltage.


%}

N_thrusters = 8;
pwms_int32 = int32(1500*ones(N_thrusters,1)); 
pwms = 1500*ones(N_thrusters,1,'double');

for k = 1:N_thrusters
    force = double(force_list(k));


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
            if(mod(k,2==0))%for the even thrusters
                force_column = ccw_ref(lower_voltage_index);
            else
                force_column = cw_ref(lower_voltage_index);
            end
        else
            if(mod(k,2==0))%for the even thrusters
                force_column = ccw_ref(:,lower_voltage_index) + (voltage-voltage_list(lower_voltage_index))*(ccw_ref(:,upper_voltage_index)-ccw_ref(:,lower_voltage_index))/(voltage_list(upper_voltage_index)-voltage_list(lower_voltage_index));

            else
                force_column = cw_ref(:,lower_voltage_index) + (voltage-voltage_list(lower_voltage_index))*(cw_ref(:,upper_voltage_index)-cw_ref(:,lower_voltage_index))/(voltage_list(upper_voltage_index)-voltage_list(lower_voltage_index));

            end
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
    pwms(k) = pwm_cmd;

end
pwms_int32(:) = int32(pwms(:));
