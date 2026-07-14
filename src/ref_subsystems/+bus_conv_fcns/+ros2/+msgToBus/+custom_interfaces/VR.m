function slBusOut = VR(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    currentlength = length(slBusOut.velocity_data);
    for iter=1:currentlength
        slBusOut.velocity_data(iter) = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.velocity_data(iter),slBusOut(1).velocity_data(iter),varargin{:});
    end
    slBusOut.velocity_data = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.velocity_data,slBusOut(1).velocity_data,varargin{:});
    slBusOut.altitude = single(msgIn.altitude);
    slBusOut.fom = single(msgIn.fom);
    slBusOut.time = single(msgIn.time);
    currentlength = length(slBusOut.covariance);
    for iter=1:currentlength
        slBusOut.covariance(iter) = bus_conv_fcns.ros2.msgToBus.std_msgs.Float32MultiArray(msgIn.covariance(iter),slBusOut(1).covariance(iter),varargin{:});
    end
    slBusOut.covariance = bus_conv_fcns.ros2.msgToBus.std_msgs.Float32MultiArray(msgIn.covariance,slBusOut(1).covariance,varargin{:});
    if (nargin == 5) && varargin{3} % Cast 64-bit integers to double
        slBusOut.time_of_validity = double(msgIn.time_of_validity);
    else
        slBusOut.time_of_validity = int64(msgIn.time_of_validity);
    end
    if (nargin == 5) && varargin{3} % Cast 64-bit integers to double
        slBusOut.time_of_transmission = double(msgIn.time_of_transmission);
    else
        slBusOut.time_of_transmission = int64(msgIn.time_of_transmission);
    end
    slBusOut.status = uint8(msgIn.status);
    slBusOut.valid = uint8(msgIn.valid);
end
