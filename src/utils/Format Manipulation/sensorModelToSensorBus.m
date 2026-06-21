function sensor_meas = sensorModelToSensorBus(imu_readings, dvl_readings)

%Unpack the bus data
linAccel = imu_readings.imu_acc;
Gyro = imu_readings.imu_w;
Mag = imu_readings.imu_mag;
new_imu_flag = imu_readings.new_imu_flag;

eul_dvl = dvl_readings.Eul_dvl;
Ri_dvl = dvl_readings.Ri_dvl;
dRb = dvl_readings.dRb_dvl;
alt_meas_dvl = dvl_readings.alt_dvl;
dRb_cov_dvl = dvl_readings.dRb_cov_dvl;
new_vr_flag = dvl_readings.new_vr_flag;
new_drr_flag = dvl_readings.new_drr_flag;

%Pack into the sensor message structure
sensor_meas.dvl_std = 0;
sensor_meas.dvl_eul = eul_dvl;
sensor_meas.dvl_pos = Ri_dvl;

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

sensor_meas.imu_new_msg_flag = new_imu_flag;
sensor_meas.dvl_vr_new_msg_flag = new_vr_flag;
sensor_meas.dvl_drr_new_msg_flag = new_drr_flag;

end