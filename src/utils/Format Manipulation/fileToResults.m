function results = fileToResults(results, path)
%{
This function loads all the .mat files of data found at the path and adds
them to the results structure from the simulation as timeseries so they can
be plotted by the TimePlot and plotAllResults infrastructure.
%}

files = dir(fullfile(path, '*.mat'));

for k = 1:length(files)
    fname = files(k).name;
    data_struct_k = load(fullfile(path, fname));
    %if the type of the data structure is timeseries, stick in into results
    varName = matlab.lang.makeValidName(erase(fname, '.mat'));
    data_k = data_struct_k.(varName);
    if(isa(data_k,'timeseries') || istimetable(data_k))
        results.(varName) = data_k;
    elseif(isequal(varName,'sensors'))
        results = sensorsToResults(data_k, results);
    end

end


end