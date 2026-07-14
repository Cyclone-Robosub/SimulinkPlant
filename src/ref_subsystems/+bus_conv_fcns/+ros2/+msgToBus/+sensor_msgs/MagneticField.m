function slBusOut = MagneticField(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    currentlength = length(slBusOut.header);
    for iter=1:currentlength
        slBusOut.header(iter) = bus_conv_fcns.ros2.msgToBus.std_msgs.Header(msgIn.header(iter),slBusOut(1).header(iter),varargin{:});
    end
    slBusOut.header = bus_conv_fcns.ros2.msgToBus.std_msgs.Header(msgIn.header,slBusOut(1).header,varargin{:});
    currentlength = length(slBusOut.magnetic_field);
    for iter=1:currentlength
        slBusOut.magnetic_field(iter) = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.magnetic_field(iter),slBusOut(1).magnetic_field(iter),varargin{:});
    end
    slBusOut.magnetic_field = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.magnetic_field,slBusOut(1).magnetic_field,varargin{:});
                    currentlength = length(slBusOut.magnetic_field_covariance);
                    slBusOut.magnetic_field_covariance = double(msgIn.magnetic_field_covariance(1:currentlength));
end
