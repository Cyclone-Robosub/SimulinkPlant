function plotFb(Fb)
    t = Fb.Time; %Nx1
    Fb = squeeze(Fb.Data); %Nx3
    Fb = enforceTallSkinny(Fb);
    
    if(isValidPlotData(t,Fb,[length(t),3]))
        figure('Name','Fb','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Fb(:,k))
        end
        xlabel("Time (s)")
        ylabel("Force (N))")
        title("Total Force in the Body Frame")
        legend("Fb_x","Fb_y","Fb_z")
    else
        warning("Invalid dataset detected in plotFb. Plotting was aborted.")
    end
end