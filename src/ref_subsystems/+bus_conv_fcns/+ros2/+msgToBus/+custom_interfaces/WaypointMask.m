function slBusOut = WaypointMask(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    slBusOut.x = logical(msgIn.x);
    slBusOut.y = logical(msgIn.y);
    slBusOut.z = logical(msgIn.z);
    slBusOut.roll = logical(msgIn.roll);
    slBusOut.pitch = logical(msgIn.pitch);
    slBusOut.yaw = logical(msgIn.yaw);
end
