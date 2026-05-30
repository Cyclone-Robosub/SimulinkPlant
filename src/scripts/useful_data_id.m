%% Useful_data_id
% https://drive.google.com/file/d/1LuO8OkZg2F-xFYocdrsW4XlXaTFlmWro/view?usp=sharing
%notes:
%       exclude files before 3:45 pm, 4:02 pm, and 5:23 pm


if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end


%% useful file
% get all the folders that have pwm and Rb data
data_files = dir(prj_path_list.user_data_path);
data_files = valid_data_files(data_files);
if ~isfolder(fullfile(prj_path_list.user_data_path,"L"))
    mkdir(fullfile(prj_path_list.user_data_path,"L"));
    mkdir(fullfile(prj_path_list.user_data_path,"M"));
    mkdir(fullfile(prj_path_list.user_data_path,"N"));
end
result_count_L = 1;
result_count_M = 1;
result_count_N = 1;


for k = 1:numel(data_files)
%% plotting the  Mb_FB_cmd data
save_file = data_files(k).name;
file_extension = strsplit(data_files(k).name,{'/','\'});
file_extension = file_extension(end);
save_file = fullfile(prj_path_list.user_data_path,save_file);
results = Simulink.SimulationOutput;
results = fileToResults(results,save_file);
save_file = string(file_extension{1});

%run("setup_plots_EST.m")
%plot_names ={"FB_force_moment_cmd","pwm_cmd"};
%plotAllOutputs(plots,results,plot_names)


%% chop shop
noise = [5,5,10]; %[Nm] approx moment noise apmlitude of each moment
%priority = 2; %1 = L, M = 2, N = 3
snr_tol = 5; %signal ratio tolerance for moment data
dt_sim = mean(results.pwms.Time(2:end)-results.pwms.Time(1:(end-1))); %[s]
tcrit = 20; %[ds] minimum length of a moment command for the data to be considered useful
tcrit2 = 5; % tcrit didn't do what i wanted it to do... so i made a second one....

L_mom = results.Mb_FB_cmd.Data(:,1);
[mag_bool_L, mask_L] = snrThreshold(L_mom,noise(1),snr_tol,tcrit,dt_sim);

M_mom = results.Mb_FB_cmd.Data(:,2);
[mag_bool_M, mask_M] = snrThreshold(M_mom,noise(2),snr_tol,tcrit,dt_sim);

N_mom = results.Mb_FB_cmd.Data(:,3);
[mag_bool_N, mask_N] = snrThreshold(N_mom,noise(3),snr_tol,tcrit,dt_sim);
%{ 
%just for tuning the snr and tolerance :)
mag_results = results;
mag_results.Mb_FB_cmd.Data(:,1) = mask_L;
mag_results.Mb_FB_cmd.Data(:,2) = mask_M;
mag_results.Mb_FB_cmd.Data(:,3) = mask_N;
plotAllOutputs(plots,mag_results,plot_names)
clear mag_results
%}
masks = [mask_L, mask_M, mask_N];

priority = 1;
pri_name = "L";
[choppedresults,~,~,~] = dataChop(results,masks,priority,tcrit2);
%choppedresults_L(result_count_L+(0:(length(choppedresults)-1))) = choppedresults;
%result_count_L = result_count_L + length(choppedresults);
save_L = sprintf("abreviated_data_%s_%s",pri_name,save_file);
save_L = fullfile(prj_path_list.user_data_path,"L",save_L);
save(save_L, "choppedresults")

priotirty = 2;
pri_name = "M";
[choppedresults,~,~,~] = dataChop(results,masks,priority,tcrit2);
%choppedresults_M(result_count_M+(0:(length(choppedresults)-1))) = choppedresults;
%result_count_M = result_count_M + length(choppedresults);
save_M = sprintf("abreviated_data_%s_%s",pri_name,save_file);
save_M = fullfile(prj_path_list.user_data_path,"M",save_M);
save(save_M, "choppedresults")

pritority = 3;
pri_name = "N";
[choppedresults,~,~,~] = dataChop(results,masks,priority,tcrit2);
%choppedresults_N(result_count_N+(0:(length(choppedresults)-1))) = choppedresults;
%result_count_N = result_count_N + length(choppedresults);
save_N = sprintf("abreviated_data_%s_%s",pri_name,save_file);
save_N = fullfile(prj_path_list.user_data_path,"N",save_N);
save(save_N, "choppedresults")
end
%validation plot
%plotAllOutputs(plots,choppedresults(end),plot_names)


%% Nested Functions
function [mag_bool,mask] = snrThreshold(data,A_noise,snr_tol,tcrit,dt)
    snr = (data./A_noise).^2;
    mag_bool = snr > snr_tol;
    time_step = dt;
    i = 1;
    mask = mag_bool;
    while time_step <= tcrit % grouping chunks together
        for j = 1:i:(length(mag_bool)-i)
            mask(j:(j+i-1)) = sum(mag_bool(j:(j+i-1)));
        end
        time_step = time_step+dt;
        i = i+1;
    end
end

function [choppedresults,timestamps,stampname,indexstamps] = dataChop(results,masks,priority,tcrit)
% data is a result object, mask is one of the masks made by snrThreshold,
% priority is denoting roll, pitch, yaw
% outputs besides choppedresults are mostly just for debugging
    results = getResultsProperties(results, []);
    set_param
    names = results.who;
    choppedresults(1) = results;
    timestamps = zeros(1,1); 
    indexstamps = zeros(1,1);
    count = 2;
    stampname = "";
    if masks(1)
        timestamps(1,1) = results.Mb_FB_cmd.Time(1);
        indexstamps(1,1) = 1;
        stampname(1,1) = sprintf("sample_%.5g_%d",timestamps(1),masks(1,priority));
    end
    for i = 2:length(masks)
        if ~(masks(i,priority) == masks(i-1,priority))
            timestamps(count,1) = results.Mb_FB_cmd.Time(i);
            indexstamps(count,1) = i;
            stampname(count,1) = sprintf("sample_%.5g_%d",timestamps(count),masks(i,priority));
            count = count+1;
        end
    end
    if masks(end)
        timestamps(count,1) = results.Mb_FB_cmd.Time(end);
        indexstamps(count,1) = length(results.Mb_FB_cmd.Time);
        stampname(count,1) = sprintf("sample_%.5g_%d",timestamps(end),masks(end,priority));
    end
    
    count = 1;
    for j = (1):2:(length(timestamps)-1-mod(length(timestamps),2))
        if abs(timestamps(j) - timestamps(j+1))>tcrit
            choppedresults(count) = results;
            for i = 1:length(names)
                choppedresults(count).(names{i}) = addevent(choppedresults(count).(names{i}), stampname(j), timestamps(j));
                choppedresults(count).(names{i}) = addevent(choppedresults(count).(names{i}), stampname(j+1), timestamps(j+1));
                choppedresults(count).(names{i}) = gettsbetweenevents(choppedresults(count).(names{i}),stampname(j),stampname(j+1));
                %choppedresults(count).(names{i}).TimeInfo.Increment = mean(choppedresults(count).(names{i}).Time(2:end)-choppedresults(count).(names{i}).Time(1:end-1));
            end
            count = count +1;
        end
    end
end