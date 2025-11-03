function plotFTb(FTb)
    t = FTb.Time; %Nx1
    FTb = squeeze(FTb.Data)'; %Nx3

    if(isValidPlotData(t,FTb,[length(t),3]))
        figure('Name','FTb','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,FTb(:,k))
        end
        xlabel("Time (s)")
        ylabel("FTb (N)")
        title("Body Thruster Force")
        legend("FTbx","FTby","FTbz")
    else
        warning("Invalid dataset detected in plotFTb. Plotting was aborted.")
    end
end