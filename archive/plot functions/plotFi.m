function plotFi(Fi)
    t = Fi.Time; %Nx1
    Fi = squeeze(Fi.Data); %Nx3
    Fi = enforceTallSkinny(Fi);
    
    if(isValidPlotData(t,Fi,[length(t),3]))
        figure('Name','Fi','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Fi(:,k))
        end
        xlabel("Time (s)")
        ylabel("Force (N))")
        title("Total Force in the Inertial Frame")
        legend("Fi_x","Fi_y","Fi_z")
    else
        warning("Invalid dataset detected in plotFi. Plotting was aborted.")
    end
end