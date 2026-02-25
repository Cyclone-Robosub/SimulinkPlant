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

%pose
function [poseOrientation, poseCov, posePosition, twistAngular, twistCov, twistLinear, angVel, angVelCov, ...  
    linAccel,linAccelCov, orientatn, orientatnCov, magfieldCov, magfield] = imuParsing(IMU) 

poseCov = IMU.ahrs_database.pose.covariance;

posePosition = [IMU.ahrs_database.pose.pose.position.x; IMU.ahrs_database.pose.pose.position.y; IMU.ahrs_database.pose.pose.position.z];

poseOrientation = [IMU.ahrs_database.pose.pose.orientation.w; IMU.ahrs_database.pose.pose.orientation.x; IMU.ahrs_database.pose.pose.orientation.y; 
    IMU.ahrs_database.pose.pose.orientation.z];

%twist
twistCov = IMU.ahrs_database.twist_covariance;

twistAngular = [IMU.ahrs_database.twist.twist.angular.x; IMU.ahrs_database.twist.twist.angular.y; IMU.ahrs_database.twist.twist.angular.z];

twistLinear = [IMU.ahrs_database.twist.twist.linear.x; IMU.ahrs_database.twist.twist.linear.y; IMU.ahrs_database.twist.twist.linear.z];

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
angVelCov = IMU.imu_fusion.angular_velocity_covariance;

angVel = [IMU.imu_fusion.angular_velocity.x; IMU.imu_fusion.angular_velocity.y; IMU.imu_fusion.angular_velocity.z];

%Linear acceleration
linAccelCov = IMU.imu_fusion.linear_acceleration_covariance;

linAccel = [IMU.imu_fusion.linear_acceleration.x; IMU.imu_fusion.linear_acceleration.y; IMU.imu_fusion.linear_acceleration.z];

%orientation
orientatnCov = IMU.imu_fusion.orientatn_covariance;

orientatn = [IMU.imu_fusion.orientatn.w; IMU.imu_fusion.orientatn.x; IMU.imu_fusion.orientatn.y; IMU.imu_fusion.orientatn.z];




%LEVEL 3: IMU.mag_array

%{
2 main sections (magnetic_field, magnetic_field_covariance)

magnetic_field: 3

magnetic_field_covariance: 0
%}

%magnetic field
magfieldCov = IMU.mag_array.magnetic_field_covariance;
magfield = [IMU.mag_array.magnetic_field.x; IMU.mag_array.magnetic_field.y; IMU.mag_array.magnetic_field.z];

%LEVEL 4: IMU.pressure (fluid_pressure, variance)

%{
fluid_pressure: 0
variance; 0
%}

%fluid pressure
%fluidPressureCov = IMU.pressure.variance;
%fluidPressure = IMU.pressure.fluid_pressure;


end