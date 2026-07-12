function slBusOut = Pose6D(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    slBusOut.x = double(msgIn.x);
    slBusOut.y = double(msgIn.y);
    slBusOut.z = double(msgIn.z);
    slBusOut.roll = double(msgIn.roll);
    slBusOut.pitch = double(msgIn.pitch);
    slBusOut.yaw = double(msgIn.yaw);
end
