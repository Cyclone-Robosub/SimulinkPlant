function plotFb_cmd_PID(Fb_cmd_PID)
    t = Fb_cmd_PID.Time; %Nx1
    Fb_cmd_PID = squeeze(Fb_cmd_PID.Data)'; %Nx8
    Fb_cmd_PID = enforceTallSkinny(Fb_cmd_PID);
    
    if(isValidPlotData(t,Fb_cmd_PID,[length(t),8]))
        figure('Name','Fb_cmd_PID','NumberTitle','off')
        for k = 1:8
            subplot(4,2,k)
            plot(t,Fb_cmd_PID(:,k),'Color','b')
            xlabel("Time (s)")
            ylabel("PWM (us)")
            txt = sprintf('PID Thruster %d PWM',k-1);
            title(txt)
        end
    else
        warning("Invalid dataset detected in plotPWM. Plotting was aborted.")
    end
end