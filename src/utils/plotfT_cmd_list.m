function plotfT_cmd_list(fT_cmd_list)
    t = fT_cmd_list.Time; %Nx1
    fT_cmd_list = squeeze(fT_cmd_list.Data)'; %Nx8
 
    if(isValidPlotData(t,fT_cmd_list,[length(t),8]))
        figure('Name','fT_cmd_list','NumberTitle','off')
        for k = 1:8
            subplot(4,2,k)
            plot(t,fT_cmd_list(:,k),'Color','b')
            xlabel("Time (s)")
            ylabel("Force (N)")
            txt = sprintf('Thruster %d Command Force',k-1);
            title(txt)
        end
    else
        warning("Invalid dataset detected in plotfT_cmd_list. Plotting was aborted.")
    end
end