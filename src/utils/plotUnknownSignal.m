function plotUnknownSignal(timeseries,name)
%{
This function creates a basic plot of any data found in the provided
timeseries. This function is used by plotAllOutputs to plot any timeseries
found in the results structure that does not already have a plot function
associated with it.
%}
data = squeeze(timeseries.Data);
t = squeeze(timeseries.Time);

data = enforceTallSkinny(data);
[~,m] = size(data);
%loop through each column of data and add it to the plot
figure('Name',name,'NumberTitle','off') %set the panel name to the input name
hold on
legend_list = [];
for k = 1:m
    plot(t,data(:,k))
end
xlabel("Time (s)")
ylabel("?")
title(sprintf("Unknown Variable ""%s""",name))
legend(arrayfun(@(x) sprintf("component %d",x),1:m)) %create automatic legend names
end