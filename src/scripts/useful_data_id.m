%% Useful_data_id
% https://drive.google.com/file/d/1LuO8OkZg2F-xFYocdrsW4XlXaTFlmWro/view?usp=sharing
%notes:
%       exclude files before 3:45 pm, 4:02 pm, and 5:23 pm

%% useful file
% get all the folderst that have a pwm.mat filedata_files = dir(prj_path_list.user_data_path);
data_files = dir(prj_path_list.user_data_path);
data_files = valid_data_files(data_files);

%% plotting the  Mb_FB_cmd data
save_file = data_files(end).name;
save_file = fullfile(prj_path_list.user_data_path,save_file);
results = Simulink.SimulationOutput;
results = fileToResults(results,save_file);

run("setup_plots_EST.m")
plot_names ={"FB_force_moment_cmd","pwm_cmd"};
%plotAllOutputs(plots,results,plot_names)


%% chop shop
mom_noise_A = 5; %[Nm] approx moment noise apmlitude
snr_tol = 5; %signal ratio tolerance for moment data
dt_sim =mean(results.pwms.Time(2:end)-results.pwms.Time(1:(end-1))); %[s]
tcrit = 5; %[ms] minimum length of a moment command for the data to be considered useful

L_mom = results.Mb_FB_cmd.Data(:,1);
[mag_bool_L, mask_L] = snrThreshold(L_mom,mom_noise_A,snr_tol,tcrit,dt_sim);

M_mom = results.Mb_FB_cmd.Data(:,2);
[mag_bool_M, mask_M] = snrThreshold(M_mom,mom_noise_A,snr_tol,tcrit,dt_sim);

N_mom = results.Mb_FB_cmd.Data(:,3);
[mag_bool_N, mask_N] = snrThreshold(N_mom,mom_noise_A,snr_tol,tcrit,dt_sim);

mag_results = results;
mag_results.Mb_FB_cmd.Data(:,1) = mask_L;
mag_results.Mb_FB_cmd.Data(:,2) = mask_M;
mag_results.Mb_FB_cmd.Data(:,3) = N_mom;
plotAllOutputs(plots,mag_results,plot_names)

masks = [mask_L,mask_M,mask_N];
priority = 1; %1 = L, M = 2, N = 3
[chopped_result,timestamps] = dataChop(results,masks,priority)
save("abreviated_data", "chopped_result")

function [mag_bool,mask] = snrThreshold(data,A_noise,snr_tol,tcrit,dt)
    snr = (data./A_noise).^2;
    mag_bool = snr > snr_tol;
    time_step = dt;
    i = 1;
    mask = mag_bool;
    while time_step <= tcrit
        for j = 1:i:(length(mag_bool)-i)
            mask(j:(j+i-1)) = sum(mag_bool(j:(j+i-1)));
        end
        time_step = time_step+dt;
        i = i+1;
    end


end

function [choppedresults,timestamps] = dataChop(results,masks,priority)
% data is a result object, mask is one of the masks made by snrThreshold,
% priority is denoting roll, pitch, yaw
    names = results.who;
    choppedresults = results;
    timestamps = zeros(2,1); 
    stamp_name = zeros(2,1);
    for i = 2:length(masks)
        if ~(masks(i,priority) == masks(i-1,priority))
            timestamps(i) = i*choppedresults.Eul.TimeInfo.Increment;
            stamp_name(i) = sprintf("sample_%d",timestamps(i));
        end
    end
    for i = 1:length(names)
        for j = 1:length(timestamps)
            choppedresults.(names(i)) = addevent(choppedresults.(names(i)),stamp_name(j), timestamps(j));
        end
        %choppedresults.(names(i)) = gettsbetwenevents(results.(names),stamp_name);
    end

end