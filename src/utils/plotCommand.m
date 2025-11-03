function plotCommand(command)

    t = command.Time; %Nx1
    command = squeeze(command.Data)'; %Nx2

    ID = command(:,1); %1xN
    %Intensity = command(:,2); %1xN
    if(isValidPlotData(t,ID,[length(t),1]))
        figure
        plot(t,ID,'Color','k')
        xlabel("Time (s)")
        ylabel("Command ID")
        title("Command ID")
    else
        warning("Invalid dataset detected in plotCommand. Plotting was aborted.")
    end

end