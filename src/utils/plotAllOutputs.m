function plotAllOutputs(results,plots, target_plot_names, prj_path_list, save_plots_flag)
%{
This function creates and saves plots.

Inputs:
results: A SimulationOutput containing the timeseries outputs of
to-workspace blocks in a Simulink model

plots: A vector of ClassPlot instances describing the layout of each plot

target_plot_names: A cell array of plot names that the user wants to plot.
If empty, all plots are generated.

prj_path_list: The list of file paths associated with the project,
including prj_path_list.sim_data_path which is used to create a plot. 

save_plots_flag: Controls if images of the plots are saved to the
sim_data_path.

%}

%check if user wants all the plots or just a subset
if(isempty(target_plot_names))
    plot_all_flag = true;
else
    plot_all_flag = false;
end

if(plot_all_flag) %plot everything
    for k = 1:length(plots)
        plot(plots(k),results);
        if(save_plots_flag)
            if(~isfolder(prj_path_list.sim_data_path))
                mkdir(prj_path_list.sim_data_path)
            end
                frame = getframe(gcf);
                img = frame.cdata;
                imwrite(img, fullfile(prj_path_list.sim_data_path,plots(k).name + ".png"));
                        
        end
    end
else
    for k = 1:length(plots) %just plot target_plot_names
        if(any(strcmp(plots(k).name, cellstr(target_plot_names))))
            plot(plots(k),results);
            if(save_plots_flag)
                if(~isfolder(prj_path_list.sim_data_path))
                    mkdir(prj_path_list.sim_data_path)
                end
                frame = getframe(gcf);
                img = frame.cdata;
                imwrite(img, fullfile(prj_path_list.sim_data_path,plots(k).name + ".png"));
            
            end
        
        end
    end
end

    
end
