classdef ClassPlot
    %{
    Class used by plotClassPlot and setupPlots to create high quality plots
    with a large amount of code reuse.
    %}
    properties
        name = "" %name used by to-workspace blocks
        subplot_dim = [1 1] %[rows, columns] size of subplots
        subtitles = {""} %{title1, title2, ...} titles for subplots
        supertitle = "" %title for overall plot
        x_axis_label = {""} %label(s) for horizontal axes
        y_axis_labels = {""} %label(s) for vertical axes
        legends = {{}} %1 cell array for each legend set, one legend set per subplot
        t
        data
        plottable_flag = False


    end

    methods
        function plot(obj)
            %{
            This function overloads the "plot" method to allow the
            plot(foo) function to input foo of type ClassPlot.
            %}

            %Code here to make the plot
            
        end

        function loadData(obj, results)
            %{
            This function populates the classes time and data fields using
            the results structure from the simulink output. It also sets
            the plottable_flag to only plot good data sets and pass without
            error otherwise.
            %}
        end

    end
end