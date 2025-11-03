function plotRi(Ri)
    t = Ri.Time; %Nx1
    Ri = squeeze(Ri.Data); %Nx3
   
    if(isValidPlotData(t,Ri,[length(t),3]))
        figure('Name','Ri','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Ri(:,k))
        end
            xlabel("Time (s)")
            ylabel("Ri (m)")
            title("Intertial Position")
            legend("Rix","Riy","Riz")
    else
        warning("Invalid dataset detected in plotRi. Plotting was aborted.")
    end
end