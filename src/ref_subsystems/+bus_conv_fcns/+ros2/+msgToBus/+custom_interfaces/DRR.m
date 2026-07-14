function slBusOut = DRR(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    if (nargin == 5) && varargin{3} % Cast 64-bit integers to double
        slBusOut.time_stamp = double(msgIn.time_stamp);
    else
        slBusOut.time_stamp = int64(msgIn.time_stamp);
    end
    currentlength = length(slBusOut.position);
    for iter=1:currentlength
        slBusOut.position(iter) = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.position(iter),slBusOut(1).position(iter),varargin{:});
    end
    slBusOut.position = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.position,slBusOut(1).position,varargin{:});
    currentlength = length(slBusOut.angle);
    for iter=1:currentlength
        slBusOut.angle(iter) = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.angle(iter),slBusOut(1).angle(iter),varargin{:});
    end
    slBusOut.angle = bus_conv_fcns.ros2.msgToBus.geometry_msgs.Vector3(msgIn.angle,slBusOut(1).angle,varargin{:});
    slBusOut.pos_std = single(msgIn.pos_std);
    slBusOut.status = uint8(msgIn.status);
end
