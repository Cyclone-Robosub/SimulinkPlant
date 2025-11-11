function plotw(w)
    t = w.Time; %Nx1
    w = squeeze(w.Data); %Nx3
    w = enforceTallSkinny(w);

    if(isValidPlotData(t,w,[length(t),3]))
        figure('Name','w','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,w(:,k))
        end
        xlabel("Time (s)")
        ylabel("Angular Velocity (rad/s)")
        title("Angular Velocity")
        legend("wx","wy","wz")
    else
        warning("Invalid dataset detected in plotw. Plotting was aborted.")
    end
end