function plotPWM(PWM)
    t = PWM.Time; %Nx1
    PWM = squeeze(PWM.Data)'; %Nx8
 
    if(isValidPlotData(t,PWM,[length(t),8]))
        figure('Name','PWM','NumberTitle','off')
        for k = 1:8
            subplot(4,2,k)
            plot(t,PWM(:,k),'Color','b')
            xlabel("Time (s)")
            ylabel("PWM (us)")
            txt = sprintf('Thruster %d PWM',k-1);
            title(txt)
        end
    else
        warning("Invalid dataset detected in plotPWM. Plotting was aborted.")
    end
end