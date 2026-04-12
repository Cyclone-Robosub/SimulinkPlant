%{
The following code parses through the use inputs of the gamepad message.
Becasue of the mixed data typing of the message it is necessary to parse
the message as so.
%}

function [pose_inputs, mode_inputs] = gamepad_parser(user_input)

input = user_input;

pose_inputs = [input.x;
               input.y;
               input.rise;
               input.sink;
               input.yaw;
               input.pitch];

mode_inputs = [input.cross_button;
               input.square_button;
               input.triangle_button;
               input.circle_button;
               input.dpad_down;
               input.dpad_left;
               input.dpad_up;
               input.dpad_right;
               input.bumper_left;
               input.bumper_right;
               input.start;
               input.select;
               input.joystick_press_left;
               input.joystick_press_right];
end