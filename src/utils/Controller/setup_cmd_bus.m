%{
To pass structures between Simulink blocks we will use a bus. The command
bus is created here.
%}

template_command = struct("cmd_id",int8('16characters____'),"wp",...
    zeros(6,1),"wp_mask",zeros(6,1),"wp_tol",zeros(6,1),"hold_time",0,...
    "obj_id",int8('16characters____'),"obj_conf",0,"trick_id",...
    int8('16characters____'),"timeout",0);

%Setup the bus. Name must match exactly when referred to in the simulation.
Simulink.Bus.createObject(template_command);

%change the default name of the bus from slBus1 to cmd_bus
cmd_bus = slBus1;
clear slBus1; 

cmd_bus.Description = ['Bus to store commands from the Executive to...' ...
    ' Low Level Controller.'];
