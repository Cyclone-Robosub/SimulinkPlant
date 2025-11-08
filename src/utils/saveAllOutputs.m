function saveAllOutputs(results,path)
%{
This function inputs the result structure from a simulation and saves all
data contained in it to a comma deliminated file.
%}

%extract fields from results
fields = results.who;

%get the timestamp to be used as the folder name
this_time = datetime('now');
time_string = string(this_time);

%create a new folder at the path
filepath = fullfile(path,time_string);
mkdir(filepath);


for k = 1:length(fields)
    name_struct = fields(k);
    name = name_struct{1};
    
    if(name ~= "tout")
        this_data_struct = results.(name);
        t = squeeze(this_data_struct.Time);
        data = squeeze(this_data_struct.Data);
    
        to_save = [t,data];
        writematrix(to_save,fullfile(filepath,strcat(name,'.txt')));
    end
end

end

