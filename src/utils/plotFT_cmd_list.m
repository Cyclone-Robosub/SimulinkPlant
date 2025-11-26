function plotFT_cmd_list(FT_cmd_list)
    t = FT_cmd_list.Time; %Nx1
    FT_cmd_list = squeeze(FT_cmd_list.Data)'; %Nx8
 
    if(isValidPlotData(t,FT_cmd_list,[length(t),8]))
        figure('Name','FT_cmd_list','NumberTitle','off')
        for k = 1:8
            subplot(4,2,k)
            plot(t,FT_cmd_list(:,k),'Color','b')
            xlabel("Time (s)")
            ylabel("Force (N)")
            txt = sprintf('Thruster %d Command Force',k-1);
            title(txt)
        end
    else
        warning("Invalid dataset detected in plotFT_cmd_list. Plotting was aborted.")
    end
end