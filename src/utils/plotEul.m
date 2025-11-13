function plotEul(Eul)
    t = Eul.Time; %Nx1
    Eul = squeeze(Eul.Data); %Nx3
    Eul = enforceTallSkinny(Eul);
    
    if(isValidPlotData(t,Eul,[length(t),3]))
        figure('Name','Eul','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Eul(:,k))
        end
        xlabel("Time (s)")
        ylabel("Angle (rad)")
        title("Euler Angles")
        legend("Roll","Pitch","Yaw")
    else
        warning("Invalid dataset detected in plotEul. Plotting was aborted.")
    end
end