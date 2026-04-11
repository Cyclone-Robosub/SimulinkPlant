%{
To pass structures between Simulink blocks we will use a bus. The command
bus is created here.
%}

%define the elements of the cmd bus
cmd_id = Simulink.BusElement; %example 'drive_to_world_waypoint'
cmd_id.Name = 'cmd_id';
cmd_id.DataType = 'int8';
cmd_id.Dimensions = [1,16];

wp = Simulink.BusElement; %example [1 2 3 4 5 6]'
wp.Name = 'wp';
wp.DataType = 'double';
wp.Dimensions = [6,1];

wp_mask = Simulink.BusElement; %example [1 1 1 0 0 0]'
wp_mask.Name = 'wp_mask';
wp_mask.DataType = 'double';
wp_mask.Dimensions = [6,1];

wp_tol = Simulink.BusElement; %example [.25 .25 .25 .01 .01 .01]'
wp_tol.Name = 'wp_tol';
wp_tol.DataType = 'double';
wp_tol.Dimensions = [6,1];

hold_time = Simulink.BusElement; %example 3.5
hold_time.Name = 'hold_time';
hold_time.DataType = 'double';
hold_time.Dimensions = 1;

obj_id = Simulink.BusElement; %example 'gate_with_red_sign'
obj_id.Name = 'obj_id';
obj_id.DataType = 'int8';
obj_id.Dimensions = [1,16];

conf = Simulink.BusElement; %example 0.99
conf.Name = 'conf';
conf.DataType = 'double';
conf.Dimensions = 1;

trick_id = Simulink.BusElement; %example 'spin'
trick_id.Name = 'trick_id';
trick_id.DataType = 'int8';
trick_id.Dimensions = [1,16];


exec_timeout = Simulink.BusElement; %example 10.0
exec_timeout.Name = 'exec_timeout';
exec_timeout.DataType = 'double';
exec_timeout.Dimensions = 1;

cmd_bus = Simulink.Bus;

cmd_bus.Elements = [cmd_id, wp, wp_mask, wp_tol, hold_time, obj_id,...
    conf, trick_id, exec_timeout];

