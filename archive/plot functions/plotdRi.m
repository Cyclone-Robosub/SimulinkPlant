function plotdRi(dRi)
    t = dRi.Time; %Nx1
    dRi = squeeze(dRi.Data); %Nx3
    dRi = enforceTallSkinny(dRi);
    
    if(isValidPlotData(t,dRi,[length(t),3]))
        figure('Name','dRi','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,dRi(:,k))
        end
        xlabel("Time (s)")
        ylabel("dRi (m/s)")
        title("Intertial Velocity")
        legend("dRix","dRiy","dRiz")
    else
        warning("Invalid dataset detected in plotdRi. Plotting was aborted.")
    end
end