todayDate = datetime();
save_file_path = fullfile(saved_images_path,"KeyPointData/Save_" + todayDate.Day + "_" + todayDate.Month + "_" + todayDate.Year + "_" + todayDate.Hour + todayDate.Minute + floor(todayDate.Second));
mkdir(save_file_path);
mkdir(fullfile(save_file_path, "CSV_Files"));
mkdir(fullfile(save_file_path, "Pictures"));
for i = 1:numPerspectives
    writematrix(results.keyPointsImageList(i + startDelay_KP,:), fullfile(save_file_path,"CSV_Files/frame_" + i + ".csv"));
    camImage = results.camL_Feed(:, :, :, i + startDelay_KP + 2);
    imwrite(camImage, fullfile(save_file_path,"Pictures/frame_" + i + ".png"));
    lkp = results.keyPointsImageList(i + startDelay_KP, :);
    drawnImage = insertShape(camImage, 'Line', [lkp(2) lkp(3) lkp(5) lkp(6)], 'Color', 'y');
    drawnImage = insertShape(drawnImage, 'Line', [lkp(2) lkp(3) lkp(8) lkp(9)], 'Color', 'y');
    drawnImage = insertShape(drawnImage, 'Line', [lkp(5) lkp(6) lkp(11) lkp(12)], 'Color', 'y');
    drawnImage = insertShape(drawnImage, 'Line', [lkp(11) lkp(12) lkp(8) lkp(9)], 'Color', 'y');
    imwrite(drawnImage, fullfile(save_file_path,"Pictures/drawn_frame_" + i + ".png"));

end
clear i todayDate save_file_path camImage lkp;