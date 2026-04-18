%{
Creates a structure to store the velocity and angular velocity targets for
Rate Stabilized Feedforward (RSFF) maneuvers. These maneuvers fall under
the Duration Trick category with keyworks rsff_<maneuver name>, for example
rsff_forward to go forward.

The hardcoded velocity values in this script can be used to tune the
intensity of the maneuver.

These velocities are injected downstream of the guidance law so that they
bypass the position PID controller but use the velocity PID controller.

%}

%rate command in the form [dRb_u; wb_u]
rsff_stop      = [ 0; 0; 0; 0; 0; 0];
rsff_forward   = [ .5; 0; 0; 0; 0; 0];
rsff_backward  = [-.5; 0; 0; 0; 0; 0];
rsff_right     = [ 0; 1; 0; 0; 0; 0];
rsff_left      = [ 0;-1; 0; 0; 0; 0];
rsff_up        = [ 0; 0;-1; 0; 0; 0];
rsff_down      = [ 0; 0; 1; 0; 0; 0];
rsff_rollRight = [ 0; 0; 0; 1; 0; 0];
rsff_rollLeft  = [ 0; 0; 0;-1; 0; 0];
rsff_pitchUp   = [ 0; 0; 0; 0; 1; 0];
rsff_pitchDown = [ 0; 0; 0; 0;-1; 0];
rsff_yawRight  = [ 0; 0; 0; 0; 0; 1];
rsff_yawLeft   = [ 0; 0; 0; 0; 0;-1];


%% Setup RSFF_Maneuver struct
RSFF_maneuvers = struct( 'rsff_stop',rsff_stop,...
    'rsff_forward',rsff_forward,'rsff_backward',rsff_backward, ...
    'rsff_right',rsff_right,'rsff_left',rsff_left,...
    'rsff_up',rsff_up,'rsff_down',rsff_down, ...
    'rsff_rollRight',rsff_rollRight,'rsff_rollLeft',rsff_rollLeft, ...
    'rsff_pitchUp',rsff_pitchUp,'rsff_pitchDown',rsff_pitchDown,...
    'rsff_yawRight',rsff_yawRight,'rsff_yawLeft',rsff_yawLeft);

RSFF_maneuver_bus = Simulink.Bus;

%% Fields from DVL DRR
el = Simulink.BusElement;
el.Name = "rsff_stop";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_forward";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_backward";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_right";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_left";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_up";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_down";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_rollRight";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_rollLeft";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_pitchUp";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_pitchDown";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_yawRight";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = "rsff_yawLeft";
el.DataType = "double";
el.Dimensions = [6 1];
RSFF_maneuver_bus.Elements(end+1) = el;