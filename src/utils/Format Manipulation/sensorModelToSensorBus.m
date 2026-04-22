function sensor_meas = sensorModelToSensorBus(linAccel,Gyro,Mag,dRb,alt_meas_dvl,dRb_cov_dvl, eul_dvl)

    sensor_meas.dvl_std = 0;
    sensor_meas.dvl_eul = eul_dvl;
    sensor_meas.dvl_pos = zeros(3,1);

    sensor_meas.dvl_vel = dRb;
    sensor_meas.dvl_alt = alt_meas_dvl;
    sensor_meas.dvl_cov = dRb_cov_dvl;

    sensor_meas.dvl_fom = 0;
    sensor_meas.imu_pose_cov = zeros(3,3);
    sensor_meas.imu_pose_pos = zeros(3,1);
    sensor_meas.imu_pos_quat = zeros(4,1);
    sensor_meas.imu_twist_cov = zeros(3,1);
    sensor_meas.imu_twist_ang = zeros(3,1);
    sensor_meas.imu_twist_lin = zeros(3,1);
    sensor_meas.imu_ang_vel_cov = zeros(3,3);

    sensor_meas.imu_ang_vel = Gyro;

    sensor_meas.imu_lin_acc_cov = zeros(3,3);

    sensor_meas.imu_lin_acc = linAccel;

    sensor_meas.imu_quat_cov = zeros(4,4);
    sensor_meas.imu_quat = zeros(4,1);

    sensor_meas.imu_mag = Mag;

    sensor_meas.imu_mag_cov = zeros(3,3);
end