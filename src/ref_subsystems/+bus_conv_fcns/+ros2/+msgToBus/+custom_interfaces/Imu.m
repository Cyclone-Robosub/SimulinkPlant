function slBusOut = Imu(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    currentlength = length(slBusOut.imu_fusion);
    for iter=1:currentlength
        slBusOut.imu_fusion(iter) = bus_conv_fcns.ros2.msgToBus.sensor_msgs.Imu(msgIn.imu_fusion(iter),slBusOut(1).imu_fusion(iter),varargin{:});
    end
    slBusOut.imu_fusion = bus_conv_fcns.ros2.msgToBus.sensor_msgs.Imu(msgIn.imu_fusion,slBusOut(1).imu_fusion,varargin{:});
    currentlength = length(slBusOut.mag_array);
    for iter=1:currentlength
        slBusOut.mag_array(iter) = bus_conv_fcns.ros2.msgToBus.sensor_msgs.MagneticField(msgIn.mag_array(iter),slBusOut(1).mag_array(iter),varargin{:});
    end
    slBusOut.mag_array = bus_conv_fcns.ros2.msgToBus.sensor_msgs.MagneticField(msgIn.mag_array,slBusOut(1).mag_array,varargin{:});
    currentlength = length(slBusOut.pressure);
    for iter=1:currentlength
        slBusOut.pressure(iter) = bus_conv_fcns.ros2.msgToBus.sensor_msgs.FluidPressure(msgIn.pressure(iter),slBusOut(1).pressure(iter),varargin{:});
    end
    slBusOut.pressure = bus_conv_fcns.ros2.msgToBus.sensor_msgs.FluidPressure(msgIn.pressure,slBusOut(1).pressure,varargin{:});
    currentlength = length(slBusOut.ahrs_database);
    for iter=1:currentlength
        slBusOut.ahrs_database(iter) = bus_conv_fcns.ros2.msgToBus.nav_msgs.Odometry(msgIn.ahrs_database(iter),slBusOut(1).ahrs_database(iter),varargin{:});
    end
    slBusOut.ahrs_database = bus_conv_fcns.ros2.msgToBus.nav_msgs.Odometry(msgIn.ahrs_database,slBusOut(1).ahrs_database,varargin{:});
    slBusOut.roll = double(msgIn.roll);
    slBusOut.pitch = double(msgIn.pitch);
end
