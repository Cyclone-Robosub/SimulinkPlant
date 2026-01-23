function plotMb_cmd_PID(Mb_cmd_PID)
    t = Mb_cmd_PID.Time; %Nx1
    Mb_cmd_PID = squeeze(Mb_cmd_PID.Data); %Nx3

    Mb_cmd_PID = enforceTallSkinny(Mb_cmd_PID);
   
    if(isValidPlotData(t,Mb_cmd_PID,[length(t),3]))
        figure('Name','Mb_cmd_PID','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Mb_cmd_PID(:,k))
        end
            xlabel("Time (s)")
            ylabel("Moment (Nm)")
            title("Commanded Moment from PID")
            legend("Mb_cmd_PIDx","Mb_cmd_PIDy","Mb_cmd_PIDz")
    else
        warning("Invalid dataset detected in plotMb_cmd_PID. Plotting was aborted.")
    end
end