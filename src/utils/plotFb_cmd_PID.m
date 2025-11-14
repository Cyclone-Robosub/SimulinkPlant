function plotFb_cmd_PID(Fb_cmd_PID)
    t = Fb_cmd_PID.Time; %Nx1
    Fb_cmd_PID = squeeze(Fb_cmd_PID.Data); %Nx3

    Fb_cmd_PID = enforceTallSkinny(Fb_cmd_PID);
   
    if(isValidPlotData(t,Fb_cmd_PID,[length(t),3]))
        figure('Name','Fb_cmd_PID','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Fb_cmd_PID(:,k))
        end
            xlabel("Time (s)")
            ylabel("Force (N)")
            title("Commanded Force from PID")
            legend("Fb_cmd_PIDx","Fb_cmd_PIDy","Fb_cmd_PIDz")
    else
        warning("Invalid dataset detected in plotFb_cmd_PID. Plotting was aborted.")
    end
end