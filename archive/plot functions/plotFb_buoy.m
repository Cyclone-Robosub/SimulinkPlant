function plotFb_buoy(Fb_buoy)
    t = Fb_buoy.Time; %Nx1
    Fb_buoy = squeeze(Fb_buoy.Data); %Nx3
    Fb_buoy = enforceTallSkinny(Fb_buoy);
    
    if(isValidPlotData(t,Fb_buoy,[length(t),3]))
        figure('Name','Fb_buoy','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Fb_buoy(:,k))
        end
        xlabel("Time (s)")
        ylabel("Force (N))")
        title("Buoyant Force in the Body Frame")
        legend("Fb_buoy_x","Fb_buoy_y","Fb_buoy_z")
    else
        warning("Invalid dataset detected in plotFb_buoy. Plotting was aborted.")
    end
end