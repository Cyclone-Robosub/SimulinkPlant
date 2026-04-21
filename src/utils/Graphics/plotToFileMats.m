function plotToFileMats(path)
%{
Quick function to plot all the files from the ToFile blocks.

Eventually we will replace this with something nicer, hopefully re-using
the TimePlot code.
%}

files = dir(fullfile(path, '*.mat'));
data = struct();

varNames = [];
for k = 1:length(files)
    fname = files(k).name;
    varName = matlab.lang.makeValidName(erase(fname, '.mat'));
    varNames = [varNames, string(varName)];
    data.(varName) = load(fullfile(path, fname));

end

%loop through all the elements
for k = 1:length(varNames)
    try %this loop operates on all the variables that are not buses
        data_k = data.(varNames(k));
        fields = fieldnames(data_k);
        for j = 1:length(fields)
            timeseries_kj = data_k.(fields{j});
            time = timeseries_kj.Time(:);
            arr = enforceTallSkinny(squeeze(timeseries_kj.Data));
            [~, cols] = size(arr);
            figure('Name',fields{j},'NumberTitle','off')
            for m = 1:cols
                plot(time, arr(:,m))
                hold on
            end
            leg = arrayfun(@(x) num2str(x), 1:cols, 'UniformOutput', false);
            legend(leg)
            title(fields{j}, 'Interpreter', 'none')
           

        end
    catch
        sub_struct_k = data.(varNames(k));
        field = fieldnames(sub_struct_k);
        field = field{1};
        
        if(isequal(field,'sensors'))
            %code for sensors
            plotSensorBus(sub_struct_k);
        end    
    end
end
