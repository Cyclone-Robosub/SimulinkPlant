function saveCalibrationData(results, path)

imu_acc = enforceTallSkinny(squeeze(results.imu_lin_acc.Data));
save(fullfile(path, "imu_acc.mat"),'imu_acc','-mat');

end