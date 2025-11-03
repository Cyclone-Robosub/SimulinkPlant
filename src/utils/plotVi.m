function plotVi(Vi)
    t = Vi.Time; %Nx1
    Vi = squeeze(Vi.Data); %Nx3

    if(isValidPlotData(t,Vi,[length(t),3]))
        figure('Name','Vi','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Vi(:,k))
        end
        xlabel("Time (s)")
        ylabel("Vi (m/s)")
        title("Intertial Velocity")
        legend("Vix","Viy","Viz")
    else
        warning("Invalid dataset detected in plotVi. Plotting was aborted.")
    end
end