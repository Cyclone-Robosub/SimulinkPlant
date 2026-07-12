function slBusOut = Gamepad(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    slBusOut.x = single(msgIn.x);
    slBusOut.y = single(msgIn.y);
    slBusOut.rise = single(msgIn.rise);
    slBusOut.sink = single(msgIn.sink);
    slBusOut.yaw = single(msgIn.yaw);
    slBusOut.pitch = single(msgIn.pitch);
    slBusOut.cross_button = logical(msgIn.cross_button);
    slBusOut.square_button = logical(msgIn.square_button);
    slBusOut.triangle_button = logical(msgIn.triangle_button);
    slBusOut.circle_button = logical(msgIn.circle_button);
    slBusOut.dpad_down = logical(msgIn.dpad_down);
    slBusOut.dpad_left = logical(msgIn.dpad_left);
    slBusOut.dpad_up = logical(msgIn.dpad_up);
    slBusOut.dpad_right = logical(msgIn.dpad_right);
    slBusOut.bumper_left = logical(msgIn.bumper_left);
    slBusOut.bumper_right = logical(msgIn.bumper_right);
    slBusOut.start = logical(msgIn.start);
    slBusOut.select = logical(msgIn.select);
    slBusOut.joystick_press_left = logical(msgIn.joystick_press_left);
    slBusOut.joystick_press_right = logical(msgIn.joystick_press_right);
end
