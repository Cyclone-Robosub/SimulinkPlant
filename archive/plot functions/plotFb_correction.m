function plotFb_correction(Fb_correction)
    t = Fb_correction.Time; %Nx1
    Fb_correction = squeeze(Fb_correction.Data); %Nx3

    Fb_correction = enforceTallSkinny(Fb_correction);
   
    if(isValidPlotData(t,Fb_correction,[length(t),3]))
        figure('Name','Fb_correction','NumberTitle','off')
        hold on
        for k = 1:3
            plot(t,Fb_correction(:,k))
        end
            xlabel("Time (s)")
            ylabel("Moment (Nm)")
            title("Command Force to Account for Torque Fires")
            legend("Fb_correctionx","Fb_correctiony","Fb_correctionz")
    else
        warning("Invalid dataset detected in plotFb_correction. Plotting was aborted.")
    end
end