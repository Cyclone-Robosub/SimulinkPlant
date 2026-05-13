function results = XesttoResults(data, results)
%{
This function unpacks the X_bus class into a set of timeseries to add
to the results structure for plotting.
%}
fields = fieldnames(data);
for k = 1:length(fields)
    new_fields{k} = [fields{k},'_est']; %add est to the end to tell apart from X
end

for k = 1:length(fields)
    results.(new_fields{k}) = data.(fields{k});
end