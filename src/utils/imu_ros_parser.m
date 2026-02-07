function [est_imu_orientation]= imu_ros_parser(imu_ros_signal)
%{
The IMU has 4 data fields

imu_fusion: [1×1 struct]
mag_array: [1×1 struct]
pressure: [1×1 struct]
ahrs_database: [1×1 struct]

%}

%Unpacking IMU data fields
fusion = imu_ros_signal.imu_fusion;

mag = imu_ros_signal.mag_array;

ahrs = mu_ros_signal.ahrs_database;

%% IMU Fusion Data
fusion_orientation_q = [fusion.orientation.x,fusion.orientation.y,fusion.orientation.z,fusion.orientation.w];

est_imu_orientation = fusion_orientation_q;

fusion_orientation_q_cov = [fusion.orientation_covariance(1:3)';fusion.orientation_covariance(4:6)',fusion.orientation_covariance(7:9)'];

fusion_angular_v = [fusion.angular_velocity.x,fusion.angular_velocity.y,fusion.angular_velocity.z];

fusion_angular_v_cov = fusion.angular_velocity_covariance;

fusion_lin_accel = [fusion.linear_acceleration.x,fusion.linear_acceleration.y,fusion.linear_acceleration.z];

fusion_lin_accel_cov = fusion.linear_acceleration_covariance;

%% Magnetic Field

end