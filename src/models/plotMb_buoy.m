function plotMb_buoy(Mb_buoy)
    t = Mb_buoy.Time; %Nx1
    Mb_buoy = squeeze(Mb_buoy.Data); %Nx3
    Mb_buoy = enforceTallSkinny(Mb_buoy);
    
    if(isValidPlotData(t,Mb_buoy,[length(t),3]))
        figure('Name','Mb_buoy','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Mb_buoy(:,k))
        end
        xlabel("Time (s)")
        ylabel("Moment (Nm))")
        title("Buoyant Moment in the Body Frame")
        legend("Mb_buoy_x","Mb_buoy_y","Mb_buoy_z")
    else
        warning("Invalid dataset detected in plotMb_buoy. Plotting was aborted.")
    end
end