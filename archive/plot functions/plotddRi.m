function plotddRi(ddRi)
    t = ddRi.Time; %Nx1
    ddRi = squeeze(ddRi.Data); %Nx3
    ddRi = enforceTallSkinny(ddRi);
    
    if(isValidPlotData(t,ddRi,[length(t),3]))
        figure('Name','ddRi','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,ddRi(:,k))
        end
        xlabel("Time (s)")
        ylabel("ddRi (m/s2)")
        title("Inertial Acceleration")
        legend("ddRix","ddRiy","ddRiz")
    else
        warning("Invalid dataset detected in plotddRi. Plotting was aborted.")
    end
end