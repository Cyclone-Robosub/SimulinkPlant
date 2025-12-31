classdef ClassPlot
    %{
    Class used by plotClassPlot and setupPlots to create high quality plots
    with a large amount of code reuse.
    %}
    properties
        %set by constructor
        name
        fields
        layout
        signal_map
        subtitles
        supertitle
        h_label
        v_labels
        legends

        %set by loadData
        t
        signals = []
        valid_data_flag

    end

    methods
        function obj = ClassPlot(name, fields, layout, signal_map, v_labels,h_labels,subtitles,supertitle,legends)
            %constructor assigns class members and validates inputs

            obj.name = name;
            obj.fields = fields;
            obj.layout = layout;
            obj.signal_map = signal_map;
            obj.v_labels = v_labels;
            obj.h_label = h_labels;
            obj.subtitles = subtitles;
            obj.supertitle = supertitle;
            obj.legends = legends;

            %todo: Input validation
        end


        function obj = loadData(obj,results)
            %{
            This function populates the classes time and data fields using
            the results structure from the simulink output. It also sets
            the plottable_flag to only plot good data sets and pass without
            error otherwise.
            %}
            obj.t = results.Time;
            
            for k = 1:length(obj.fields) %for each user specified field
                %add it to the signal list if it is contained in results
                if(ismember(obj.fields(k),results.who))
                    data = squeeze(results.(obj.fields(k)).Data);
                    data = enforceTallSkinny(data);
                    obj.signals = [obj.signals,data];
                else
                    %if the necessary field is not found, don't make plot
                    obj.valid_data_flag = false;
                end
            end
            
        end

        function plot(obj)
           
            %{
            This function overloads the "plot" method to allow the
            plot(foo) function to input foo of type ClassPlot.
            %}
            %subplot structure
            n_rows = obj.layout(1);
            n_cols = obj.layout(2);
            n_plots = n_rows*n_cols;

            %create the figure
            figure('Name',obj.name,'NumberTitle','off')
            

            %loop through each subplot
            for k = 1:n_plots
                subplot(n_rows,n_cols,k)
                hold on
                %get the settings for this subplot
                signalsk = obj.signal_map{k};
                v_labelk = obj.v_labels(k);
                subtitlek = obj.subtitles(k);
                legendk = obj.legends{k};

                %plot each signal
                for j = 1:length(signalsk)
                    plot(obj.t,obj.signals(:,signalsk(j)))
                    xlabel(obj.h_label)
                    ylabel(v_labelk)
                    if(~isequal(subtitlek,""))
                        title(subtitlek)
                    end
                    
                end

                if(~isequal(legendk,""))
                    legend(legendk)
                end
            end
            
            if(~isequal(obj.supertitle,""))
                sgtitle(obj.supertitle)
            end
        end %plot

    end %methods
end %ClassPlot