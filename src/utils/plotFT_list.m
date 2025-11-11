function plotFT_list(FT_list)
    t = FT_list.Time; %Nx1
    FT_list = squeeze(FT_list.Data)'; %Nx8
    FT_list = enforceTallSkinny(FT_list);
    
    if(isValidPlotData(t,FT_list,[length(t),8]))
        figure('Name','FT_list','NumberTitle','off')
        for k = 1:8
            subplot(4,2,k)
            plot(t,FT_list(:,k),'Color','b')
            xlabel("Time (s)")
            ylabel("Thruster Force (N)")
            txt = sprintf('Thruster %d Force',k-1);
            title(txt)
        end
    else
        warning("Invalid dataset detected in plotFT_list. Plotting was aborted.")
    end
end