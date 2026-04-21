function results = sensorsToResults(data, results)
%{
This function unpacks the sensor_bus class into a set of timeseries to add
to the results structure for plotting.
%}
fields = fieldnames(data);

for k = 1:length(fields)
    results.(fields{k}) = data.(fields{k});
end
