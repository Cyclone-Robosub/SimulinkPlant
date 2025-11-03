function plotWb(Wb)
    t = Wb.Time; %Nx1
    Wb = squeeze(Wb.Data); %Nx3

    if(isValidPlotData(t,Wb,[length(t),3]))
        figure('Name','Wb','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Wb(:,k))
        end
        xlabel("Time (s)")
        ylabel("Angular Velocity (rad/s)")
        title("Angular Velocity")
        legend("Wbx","Wby","Wbz")
    else
        warning("Invalid dataset detected in plotWb. Plotting was aborted.")
    end
end