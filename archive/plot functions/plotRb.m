function plotRb(Rb)
    t = Rb.Time; %Nx1
    Rb = squeeze(Rb.Data); %Nx3

    Rb = enforceTallSkinny(Rb);
   
    if(isValidPlotData(t,Rb,[length(t),3]))
        figure('Name','Rb','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Rb(:,k))
        end
            xlabel("Time (s)")
            ylabel("Rb (m)")
            title("Body Position")
            legend("Rbx","Rby","Rbz")
    else
        warning("Invalid dataset detected in plotRb. Plotting was aborted.")
    end
end