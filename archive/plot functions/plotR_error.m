function plotR_error(R_error)
    t = R_error.Time; %Nx1
    R_error = squeeze(R_error.Data); %Nx3

    R_error = enforceTallSkinny(R_error);
   
    if(isValidPlotData(t,R_error,[length(t),3]))
        figure('Name','R_error','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,R_error(:,k))
        end
            xlabel("Time (s)")
            ylabel("R_error (m)")
            title("Intertial Position")
            legend("Rx_error","Ry_error","Rz_error")
    else
        warning("Invalid dataset detected in plotR_error. Plotting was aborted.")
    end
end