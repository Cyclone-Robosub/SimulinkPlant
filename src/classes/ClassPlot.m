classdef ClassPlot
    %{
    Class used by plotClassPlot and setupPlots to create high quality plots
    with a large amount of code reuse.
    %}
    properties
        %set by constructor
        name
        layout
        signal_map
        titles
        supertitle
        h_label
        v_labels
        legends
        valid_signal_map_flag

        %set by loadData
        data_struct
        t
        signals
        valid_data_flag


    end

    methods
        
        function obj = ClassPlot(name, layout, signal_map, h_label, v_labels, titles, legends)
            %constructor assigns class members and validates inputs

            obj.name = name;
            obj.layout = layout;
            obj.signal_map = signal_map

            %verify the number of plots equals the number of rows of the
            %signal map and stop the plotting if the map is invalid
            n_plots_expected = layout(1)*layout(2);
            [n_plots,~] = size(signal_map);
            if (n_plots ~= n_plots_expected)
                warning("Invalid signal map detected in the ClassPlot for %s. This plot will be skipped.",name)
                obj.valid_signal_map_flag = false;

            else 
                obj.valid_signal_map_flag = true;  
            end

            %additional warnings that won't stop plotting but should be
            %fixed
            if(length(v_labels) ~= n_plots_expected)
                obj.v_labels = {"Default Label"};
                warning("Invalid vertical axis labels in ClassPlot for %s.",name)
            else
                obj.v_labels = v_labels;
            end

            if(isscalar(titles)) %one title is provided
                obj.titles = {}; 
                obj.supertitle = titles{1};
            elseif(length(titles)~=n_plots_expected) %too many or too few titles is provided
                obj.titles = {};
                obj.supertitle = "Default Title";
                warning("Invalid number of titles in ClassPlot for %s",name)
            else
                obj.titles = titles; %a title is provided per plot
                obj.supertitle = [];
            end

            obj.h_label = h_label;

            %verify the legend list matches the signal map's structure
            if(size(legends) == size(signal_map))
                obj.legends = legends;
            else
                obj.legends = [];
                warning("Invalid legends in ClassPlot for %s",name)
            end




        end


        function obj = loadData(obj,results)
            %{
            This function populates the classes time and data fields using
            the results structure from the simulink output. It also sets
            the plottable_flag to only plot good data sets and pass without
            error otherwise.
            %}
            fields = results.who; %list of names in the results structure
            if(ismember(obj.name,fields))
                obj.data_struct = results.(obj.name);

                obj.t = results.Time;
                obj.data_struct
                obj.signals = squeeze(obj.data_struct.Data);
                obj.signals = enforceTallSkinny(obj.signals);

                %make sure the data is plottable
                [n_plots,signals_per_plot] = size(obj.signal_map);
                n_signals_expected = n_plots*signals_per_plot;
                [~,n_signals] = size(obj.signals);
                if(~isequal(n_signals,n_signals_expected))
                    warning("Invalid data in the ClassPlot for %s.",obj.name)
                    obj.valid_data_flag = false;
                else
                    obj.valid_data_flag = true;
                end
    
                if(length(obj.t)<2)
                    warning("Insufficient data points for plotting in ClassPlot for %s.",obj.name)
                    obj.valid_data_flag = false;
                end

            else
                %this flag will be set to invalid if the data is not in the
                %results structure without a warning
                obj.valid_data_flag = false;
            end

        end

        function plot(obj)
            %{
            This function overloads the "plot" method to allow the
            plot(foo) function to input foo of type ClassPlot.
            %}

            %Code here to make the plot
            figure('Name',obj.name,'NumberTitle','off')
            hold on
            n_plots = obj.layout(1)*obj.layout(2);
            row = 1;
            col = 1;
            for k = 1:n_plots
                %if the number of columns exceeds what is expected, reset
                %the column index and incriment to the next row
                if(col > obj.layout(2))
                    col = 1;
                    row = row + 1;
                end
                
                %figure out which signals belong on this subplot
                subplot_signal_indices = obj.signal_map(k,:);
                subplot_signals = obj.signals(:,subplot_signal_indices);

                %figure out which legends belong on this subplot
                subplot_legend = obj.legends(k,:);
                
                [~,n_signals] = size(subplot_signals);
                subplot(row,col,k)
                for j = 1:n_signals
                    plot(obj.t,subplot_signals(:,j))
                end
                xlabel(obj.h_label)
                ylabel(obj.v_labels(k))
                legend(subplot_legend);

                %if a super title is used, don't plot a title
                if isempty(obj.titles)
                    sgtitle(obj.supertitle)
                else
                    title(obj.titles(k))
                end

                %incriment the column count
                col = col + 1;
            end
            
        end
    end
end