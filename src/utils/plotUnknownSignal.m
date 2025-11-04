function plotUnknownSignal(timeseries,name)
%{
This function creates a basic plot of any data found in the provided
timeseries. This function is used by plotAllOutputs to plot any timeseries
found in the results structure that does not already have a plot function
associated with it.
%}
data = squeeze(timeseries.Data);
t = squeeze(timeseries.Time);

%get the size of data
[n,m] = size(data);

%make sure the data is a tall skinny matrix not a short wide one
if(n<m)
    data = data';
    [~,m] = size(data);
end

%loop through each column of data and add it to the plot
figure('Name',name,'NumberTitle','off') %set the panel name to the input name
hold on
for k = 1:m
    plot(t,data(:,k))
end
xlabel("Time (s)")
ylabel("?")
title(sprintf("Unknown Variable ""%s""",name))
end