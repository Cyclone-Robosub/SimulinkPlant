function plotEul_error(Eul_erro)
    t = Eul_erro.Time; %Nx1
    Eul_erro = squeeze(Eul_erro.Data); %Nx3

    Eul_erro = enforceTallSkinny(Eul_erro);
   
    if(isValidPlotData(t,Eul_erro,[length(t),3]))
        figure('Name','Eul_error','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Eul_erro(:,k))
        end
            xlabel("Time (s)")
            ylabel("Eul_error (rad)")
            title("Euler Angle Error")
            legend("Roll","Pitch","Yaw")
    else
        warning("Invalid dataset detected in plotEul_erro. Plotting was aborted.")
    end
end