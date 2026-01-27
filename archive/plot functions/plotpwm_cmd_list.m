function plotpwm_cmd_list(pwm_cmd_list)
    t = pwm_cmd_list.Time; %Nx1
    pwm_cmd_list = squeeze(pwm_cmd_list.Data)'; %Nx8
 
    if(isValidPlotData(t,pwm_cmd_list,[length(t),8]))
        figure('Name','pwm_cmd_list','NumberTitle','off')
        for k = 1:8
            subplot(4,2,k)
            plot(t,pwm_cmd_list(:,k),'Color','b')
            xlabel("Time (s)")
            ylabel("PWM (us)")
            txt = sprintf('Thruster %d Cmd PWM',k-1);
            title(txt)
        end
    else
        warning("Invalid dataset detected in plotpwm_cmd_list. Plotting was aborted.")
    end
end