function plotCommand(command)

    t = command.Time; %Nx1
    command = squeeze(command.Data); %2xN

    ID = command(1,:); %1xN
    Intensity = command(2,:); %1xN

    figure
    plot(t,ID,'Color','k')
    xlabel("Time (s)")
    ylabel("Command ID")
    title("Command ID")

end