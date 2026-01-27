function rosmsgOut = Pwms(slBusIn, rosmsgOut)
%#codegen
%   Copyright 2021 The MathWorks, Inc.
    rosmsgOut.pwms = int32(slBusIn.pwms);
end
