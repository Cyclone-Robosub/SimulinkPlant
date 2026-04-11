function saveAllOutputs(results,path,do_state_save_flag,do_gif_flag)
%{
This function inputs the result structure from a simulation and saves all
data contained in it to a comma deliminated file.
%}

%extract fields from results
fields = results.who;

%get the timestamp to be used as the folder name
this_time = datetime("now","Format","uuuu-MM-dd HH-mm-ss");
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

        %save the values that are used by the gif tool
        if(name == "Ri")
            Ri = data;
        end
        if(name == "Cib")
            Cib = data;
        end
            
        %make sure the data is oriented correctly
        [m,n,p] = size(data);
        %if data is a rotation matrix, it will be size 3x3xN.
        if((m==3)&&(n==3))
            %reshape the data to save it to a csv
            data = reshape(data,m*n,p);
        end
        if(length(t)~=m)
            data = data';
        end
       
        to_save = [t,data];
        if(do_state_save_flag)
            writematrix(to_save,fullfile(filepath,strcat(name,'.txt')));
        end
    end
end

if(do_gif_flag)
    saveStateGif(t,Ri,Cib,filepath,time_string);
end

end

