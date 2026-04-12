%{
Sets up a bus called sensor_bus for the InertiaSense IMU and Waterlinked
DVL. The functions sensorRosMsgToBus take the Imu, DDR, and VR ROS messages
and pack the states into a more convenient SimulinkBus object. This script
sets up the sensor_bus worth fields corresponding to each sensor reading.
%}

sensor_bus = Simulink.Bus;

%% Fields from DVL DRR
el = Simulink.BusElement;
el.Name = "dvl_std";
el.DataType = "double";
el.Dimensions = [1 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "dvl_eul";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "dvl_pos";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

%% Fields from DVL VR
el = Simulink.BusElement;
el.Name = "dvl_vel";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "dvl_alt";
el.DataType = "double";
el.Dimensions = [1 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "dvl_cov";
el.DataType = "double";
el.Dimensions = [3 3];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "dvl_fom";
el.DataType = "double";
el.Dimensions = [1 1];
sensor_bus.Elements(end+1) = el;

%% Fields from IMU
el = Simulink.BusElement;
el.Name = "imu_pose_cov";
el.DataType = "double";
el.Dimensions = [3 3];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_pose_pos";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_pos_quat";
el.DataType = "double";
el.Dimensions = [4 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_twist_cov";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_twist_ang";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_twist_lin";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_ang_vel_cov";
el.DataType = "double";
el.Dimensions = [3 3];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_ang_vel";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_lin_acc_cov";
el.DataType = "double";
el.Dimensions = [3 3];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_lin_acc";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_quat_cov";
el.DataType = "double";
el.Dimensions = [4 4];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_quat";
el.DataType = "double";
el.Dimensions = [4 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_mag";
el.DataType = "double";
el.Dimensions = [3 1];
sensor_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "imu_mag_cov";
el.DataType = "double";
el.Dimensions = [3 3];
sensor_bus.Elements(end+1) = el;