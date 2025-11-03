function plotMTb(MTb)
    t = MTb.Time; %Nx1
    MTb = squeeze(MTb.Data)'; %Nx3

    if(isValidPlotData(t,MTb,[length(t),3]))
        figure('Name','MTb','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,MTb(:,k))
        end
        xlabel("Time (s)")
        ylabel("MTb (N)")
        title("Body Thruster Moments")
        legend("MTbx","MTby","MTbz")
    else
        warning("Invalid dataset detected in plotMTb. Plotting was aborted.")
    end
end