%{

Create the mapping here for PWM values.
Recall that PWM 1-8 correspond to thruster postions which follow,pwm of 
each thruster on the robot

In left to right:
f = front / r = rear
l = left  / r = right
t = top   / b = bottom
PWM(1)=pwm_flt
PWM(2)=pwm_frt
PWM(3)=pwm_rlt
PWM(4)=pwm_rrt
PWM(5)=pwm_flb
PWM(6)=pwm_frb
PWM(7)=pwm_rlb
PWM(8)=pwm_rrb

%}

function pwms = pose_inputs_to_body_forces(pose_inputs)
    x_joy = pose_inputs(1);
    y_joy = pose_inputs(2);
    rise = pose_inputs(3);
    sink = pose_inputs(4);
    yaw = pose_inputs(5);
    pitch = pose_inputs(6);
    
    
    scale = 150;
    stop_set = 1500;
    max_pwm = 1500+scale;
    min_pwm = 1500-scale;
    
    %x_body and y_body mapping
    x = y_joy;
    y = x_joy;
    
    pwms_vert = stop_set*ones(1,4); %Thrusters 0,1,2,3
    pwms_horiz = stop_set*ones(1,4); %Thrusters 4,5,6,7
    inversion_mask = [1, -1, 1, -1];
    
    % Rise/Sink
    for i = 1:4
        pwms_vert(i) = pwms_vert(i) + (scale*rise - scale*sink) * inversion_mask(i);
    end
    
    %Pitch
    pwms_vert(1) = pwms_vert(1) - (scale*pitch*inversion_mask(1));
    pwms_vert(2) = pwms_vert(2) - (scale*pitch*inversion_mask(2));
    pwms_vert(3) = pwms_vert(3) + (scale*pitch*inversion_mask(3));
    pwms_vert(4) = pwms_vert(4) + (scale*pitch*inversion_mask(4));
    
    % Forwards:
    pwms_horiz(1) = pwms_horiz(1) + scale*x;
    pwms_horiz(2) = pwms_horiz(2) - scale*x;
    pwms_horiz(3) = pwms_horiz(3) + scale*x;
    pwms_horiz(4) = pwms_horiz(4) - scale*x;
    
    % Strafe:
    pwms_horiz(1) = pwms_horiz(1) + y*scale;
    pwms_horiz(2) = pwms_horiz(2) + y*scale;
    pwms_horiz(3) = pwms_horiz(3) - y*scale;
    pwms_horiz(4) = pwms_horiz(4) - y*scale;
    
    % Yaw:
    pwms_horiz(1) = pwms_horiz(1) + yaw*scale;
    pwms_horiz(2) = pwms_horiz(2) + yaw*scale;
    pwms_horiz(3) = pwms_horiz(3) + yaw*scale;
    pwms_horiz(4) = pwms_horiz(4) + yaw*scale;
    
    
    for i = 1:4
        if(pwms_horiz(i) > max_pwm)
            pwms_horiz(i) = max_pwm;
        end
        if(pwms_horiz(i) < min_pwm)
            pwms_horiz(i) = min_pwm;
        end
        if(pwms_vert(i) > max_pwm)
            pwms_vert(i) = max_pwm;
        end
        if(pwms_vert(i) < min_pwm)
            pwms_horiz(i) = min_pwm;
        end
    
    end
    
    pwms_upper = 1750;
    pwms_lower = 1150;
    
    for k = 1:4
        if(pwms_vert(k) > pwms_upper)
            pwms_vert(k) = pwms_upper;
        elseif(pwms_vert(k) < pwms_lower)
            pwms_vert(k) = pwms_lower;
        end
    
        if(pwms_horiz(k) > pwms_upper)
            pwms_horiz(k) = pwms_upper;
        elseif(pwms_horiz(k) < pwms_lower)
            pwms_horiz(k) = pwms_lower;
        end
    end

    pwms = [pwms_vert,pwms_horiz];

end