function sensors = sensorRosMsgToBus(IMU, VR, DRR)
%{
This sensor takes the ROS2 messages for the IMU, DDR, and VR and packs the
data into the sensor_bus for more convenient manipulation in Simulink.
%}
%% IMU
%IMU = ros2message("custom_interfaces/Imu")
%LEVEL ONE: IMU.imu_fusion

%{
3 main sections (pose, twist, child_frame_id)
pose: 2
    covariance: 0
    pose:2
        position: 3
        orientation: 4
twist: 2
    covariance: 0
    twist: 2
        angular: 3
        linear: 3
child_frame_id: 0 
%}        

%Pose
% imu_pose_cov = double(IMU.ahrs_database.pose.covariance);
imu_pose_cov = eye(3);

imu_pose_pos = double([IMU.ahrs_database.pose.pose.position.x; IMU.ahrs_database.pose.pose.position.y; IMU.ahrs_database.pose.pose.position.z]);

imu_pos_quat = double([IMU.ahrs_database.pose.pose.orientation.w; IMU.ahrs_database.pose.pose.orientation.x; IMU.ahrs_database.pose.pose.orientation.y; 
    IMU.ahrs_database.pose.pose.orientation.z]);

%twist
% imu_twist_cov = double(IMU.ahrs_database.twist.covariance);
imu_twist_cov = ones(3,1);
imu_twist_ang = double([IMU.ahrs_database.twist.twist.angular.x; IMU.ahrs_database.twist.twist.angular.y; IMU.ahrs_database.twist.twist.angular.z]);

imu_twist_lin = double([IMU.ahrs_database.twist.twist.linear.x; IMU.ahrs_database.twist.twist.linear.y; IMU.ahrs_database.twist.twist.linear.z]);

%child_frame_id
%childFrame = IMU.ahrs_database.child_frame_id;



%LEVEL TWO: IMU.imu_fusion.ahrs_database
%{
6 main sections (angular_velocity, angular_velocity_covariance, linear_acceleration, linear_acceleration_covariance, orientation, orientation_covariance)
angular_velocity: 3
linear_acceleration: 3
orientation: 4
%}


%Angular velocity
%imu_ang_vel_cov = double(IMU.imu_fusion.angular_velocity_covariance);
imu_ang_vel_cov = eye(3);

imu_ang_vel = double([IMU.imu_fusion.angular_velocity.x; IMU.imu_fusion.angular_velocity.y; IMU.imu_fusion.angular_velocity.z]);

%Linear acceleration
%imu_lin_acc_cov = double(IMU.imu_fusion.linear_acceleration_covariance);

imu_lin_acc_cov = eye(3);
imu_lin_acc = double([IMU.imu_fusion.linear_acceleration.x; IMU.imu_fusion.linear_acceleration.y; IMU.imu_fusion.linear_acceleration.z]);

%orientation
% imu_quat_cov = double(IMU.imu_fusion.orientation_covariance);
imu_quat_cov = eye(4);
imu_quat = double([IMU.imu_fusion.orientation.w; IMU.imu_fusion.orientation.x; IMU.imu_fusion.orientation.y; IMU.imu_fusion.orientation.z]);


%LEVEL 3: IMU.mag_array
%{
2 main sections (magnetic_field, magnetic_field_covariance)
magnetic_field: 3
magnetic_field_covariance: 0
%}

%magnetic field
imu_mag = double([IMU.mag_array.magnetic_field.x; IMU.mag_array.magnetic_field.y; IMU.mag_array.magnetic_field.z]);
% imu_mag_cov = double(IMU.mag_array.magnetic_field_covariance);
imu_mag_cov = eye(3);
%LEVEL 4: IMU.pressure (fluid_pressure, variance)
%{
fluid_pressure: 0
variance; 0
%}
%fluid pressure
%fluidPressureCov = IMU.pressure.variance;
%fluidPressure = IMU.pressure.fluid_pressure;

%% VR
dvl_vel = double([VR.velocity_data.x,VR.velocity_data.y,VR.velocity_data.z]');

dvl_alt = double(VR.altitude);

%dvl_cov = double(VR.covariance.data);
dvl_cov = eye(3);

dvl_fom = double(VR.fom);

%% DRR
dvl_std = double(DRR.pos_std);

dvl_eul = double([DRR.angle.x; DRR.angle.y; DRR.angle.z]);

dvl_pos = double([DRR.position.x; DRR.position.y; DRR.position.z]);

%% Pack Into Structure
% The order here must match the order of bus elements in setup_sensor_bus.m
sensors.dvl_std = dvl_std;
sensors.dvl_eul = dvl_eul;
sensors.dvl_pos = dvl_pos;
sensors.dvl_vel = dvl_vel;
sensors.dvl_alt = dvl_alt;
sensors.dvl_cov = dvl_cov;
sensors.dvl_fom = dvl_fom;
sensors.imu_pose_cov = imu_pose_cov;
sensors.imu_pose_pos = imu_pose_pos;
sensors.imu_pos_quat = imu_pos_quat;
sensors.imu_twist_cov = imu_twist_cov;
sensors.imu_twist_ang = imu_twist_ang;
sensors.imu_twist_lin = imu_twist_lin;
sensors.imu_ang_vel_cov = imu_ang_vel_cov;
sensors.imu_ang_vel = imu_ang_vel;
sensors.imu_lin_acc_cov = imu_lin_acc_cov;
sensors.imu_lin_acc = imu_lin_acc;
sensors.imu_quat_cov = imu_quat_cov;
sensors.imu_quat = imu_quat;
sensors.imu_mag = imu_mag;
sensors.imu_mag_cov = imu_mag_cov;
end