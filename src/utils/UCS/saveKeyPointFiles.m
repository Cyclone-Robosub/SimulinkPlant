todayDate = datetime();
save_file_path = fullfile(root_path,"SavedImages/KeyPointData/Save_" + todayDate.Day + "_" + todayDate.Month + "_" + todayDate.Year + "_" + todayDate.Hour + todayDate.Minute + floor(todayDate.Second));
mkdir(save_file_path);
mkdir(fullfile(save_file_path, "CSV_Files"));
mkdir(fullfile(save_file_path, "Pictures"));
for i = 1:numPerspectives
    writematrix(results.keyPointsImageList(i + startDelay_KP,:), fullfile(save_file_path,"CSV_Files/frame_" + i + ".csv"));
    imwrite(results.camL_Feed(:, :, :, i + startDelay_KP + 2), fullfile(save_file_path,"Pictures/frame_" + i + ".png"));
end
clear i todayDate save_file_path;