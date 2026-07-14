function rosmsgOut = Debug(slBusIn, rosmsgOut)
%#codegen
%   Copyright 2021 The MathWorks, Inc.
    rosmsgOut.message = char(slBusIn.message);
end
