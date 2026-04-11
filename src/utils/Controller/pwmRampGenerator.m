function pwms = pwmRampGenerator(t, start, stop, Tmax, mask)

if(t <= Tmax)
    pwm = (stop-start)/Tmax*t + start;  
    pwm_list = pwm.*mask;

    for j = 1:numel(pwm_list)
        pwm_list(j) = round(max(1500, min(pwm_list(j), 1800)));
    end
    pwms_list = pwm_list(:);
    pwms = int32(pwms_list);
else
    pwms = int32([1500 1500 1500 1500 1500 1500 1500 1500]');
end


end