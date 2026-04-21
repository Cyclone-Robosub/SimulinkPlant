for i = 1:numPerspectives
    writematrix(results.keyPointsImageList(i + startDelay_KP,:), fullfile(root_path,"SavedImages/KeyPointData/TextFiles/frame_" + i + ".csv"));
    imwrite(results.camL_Feed(:, :, :, i + startDelay_KP + 2), fullfile(root_path,"SavedImages/KeyPointData/Pictures/frame_" + i + ".png"));
end
clear i;