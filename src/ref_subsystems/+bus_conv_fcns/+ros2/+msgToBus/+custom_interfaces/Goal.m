function slBusOut = Goal(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
                    currentlength = length(slBusOut.command_id);
                    slBusOut.command_id = uint8(msgIn.command_id(1:currentlength)).';
    currentlength = length(slBusOut.waypoint);
    for iter=1:currentlength
        slBusOut.waypoint(iter) = bus_conv_fcns.ros2.msgToBus.custom_interfaces.Pose6D(msgIn.waypoint(iter),slBusOut(1).waypoint(iter),varargin{:});
    end
    slBusOut.waypoint = bus_conv_fcns.ros2.msgToBus.custom_interfaces.Pose6D(msgIn.waypoint,slBusOut(1).waypoint,varargin{:});
    currentlength = length(slBusOut.waypoint_mask);
    for iter=1:currentlength
        slBusOut.waypoint_mask(iter) = bus_conv_fcns.ros2.msgToBus.custom_interfaces.WaypointMask(msgIn.waypoint_mask(iter),slBusOut(1).waypoint_mask(iter),varargin{:});
    end
    slBusOut.waypoint_mask = bus_conv_fcns.ros2.msgToBus.custom_interfaces.WaypointMask(msgIn.waypoint_mask,slBusOut(1).waypoint_mask,varargin{:});
    currentlength = length(slBusOut.tolerance);
    for iter=1:currentlength
        slBusOut.tolerance(iter) = bus_conv_fcns.ros2.msgToBus.custom_interfaces.Pose6D(msgIn.tolerance(iter),slBusOut(1).tolerance(iter),varargin{:});
    end
    slBusOut.tolerance = bus_conv_fcns.ros2.msgToBus.custom_interfaces.Pose6D(msgIn.tolerance,slBusOut(1).tolerance,varargin{:});
    slBusOut.hold_time = double(msgIn.hold_time);
                    currentlength = length(slBusOut.object);
                    slBusOut.object = uint8(msgIn.object(1:currentlength)).';
    slBusOut.confidence = double(msgIn.confidence);
                    currentlength = length(slBusOut.trick);
                    slBusOut.trick = uint8(msgIn.trick(1:currentlength)).';
    slBusOut.duration = double(msgIn.duration);
end
