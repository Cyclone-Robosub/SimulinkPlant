function plotFi_buoy(Fi_buoy)
    t = Fi_buoy.Time; %Nx1
    Fi_buoy = squeeze(Fi_buoy.Data); %Nx3
    Fi_buoy = enforceTallSkinny(Fi_buoy);
    
    if(isValidPlotData(t,Fi_buoy,[length(t),3]))
        figure('Name','Fi_buoy','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Fi_buoy(:,k))
        end
        xlabel("Time (s)")
        ylabel("Force (N))")
        title("Buoyant Force in the Inertial Frame")
        legend("Fi_buoy_x","Fi_buoy_y","Fi_buoy_z")
    else
        warning("Invalid dataset detected in plotFi_buoy. Plotting was aborted.")
    end
end