function rosmsgOut = UInt8(slBusIn, rosmsgOut)
%#codegen
%   Copyright 2021 The MathWorks, Inc.
    rosmsgOut.data = uint8(slBusIn.data);
end
