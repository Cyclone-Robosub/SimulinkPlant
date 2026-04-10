max_force_default = 200;

%% Maneuver Class Instances (Tune Maneuvers Here)
manual = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"manual");
manual = manual.setID(13);
manual = manual.setForce([0 0 0 0 0 0]);

forward = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"forward");
forward = forward.setID(1);
forward = forward.setForce(20.*[1 0 0 0 0 0]); 

backward = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"backward");
backward = backward.setID(2);
backward = backward.setForce(20.*[-1 0 0 0 0 0]);

up = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"up");
up = up.setID(3);
up = up.setForce(5*[0 0 -1 0 0 0]); 

down = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"down");
down = down.setID(4);
down = down.setForce(5*[0 0 1 0 0 0]);

right = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"right");
right = right.setID(5);
right = right.setForce(5.*[0 1 0 0 0 0]);

left = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"left");
left = left.setID(6);
left = left.setForce(5.*[0 0 -1 0 0 0]); 

pitchUp = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"pitchUp");
pitchUp = pitchUp.setID(7);
pitchUp = pitchUp.setForce(5.*[0 0 0 0 1 0]); 

pitchDown = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"pitchDown");
pitchDown = pitchDown.setID(8);
pitchDown = pitchDown.setForce(5.*[0 0 0 0 -1 0]); 

yawRight = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"yawRight");
yawRight = yawRight.setID(9);
yawRight = yawRight.setForce(10*[0 0 0 0 0 1]);

yawLeft = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"yawLeft");
yawLeft = yawLeft.setID(10);
yawLeft = yawLeft.setForce(10*[0 0 0 0 0 -1]); 

rollRight = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"rollRight");
rollRight = rollRight.setID(11);
rollRight = rollRight.setForce(5*[0 0 0 1 0 0]); 

rollLeft = Maneuver(0,max_force_default,FT_wrench,MT_wrench,"rollLeft");
rollLeft = rollLeft.setID(12);
rollLeft = rollLeft.setForce(5.*[0 0 0 -1 0 0]); 


%create the structure and bus to use the maneuver class values in Simulink
%each element of the structure 
FF_maneuvers = struct('manual', manual.FT_list,'forward',...
    forward.FT_list, 'backward',backward.FT_list, 'up', up.FT_list,...
    'down', down.FT_list, 'right', right.FT_list, 'left', left.FT_list,...
    'pitchUp', pitchUp.FT_list, 'pitchDown', pitchDown.FT_list,...
    'yawRight', yawRight.FT_list, 'yawLeft', yawLeft.FT_list,...
    'rollRight', rollRight.FT_list, 'rollLeft', rollLeft.FT_list);

%% Bus Setup
%create a Simulink with matching elements
manual = Simulink.BusElement;
manual.Name = 'manual';
manual.DataType = 'double';
manual.Dimensions = [8,1];

forward = Simulink.BusElement;
forward.Name = 'forward';
forward.DataType = 'double';
forward.Dimensions = [8,1];

backward = Simulink.BusElement;
backward.Name = 'backward';
backward.DataType = 'double';
backward.Dimensions = [8,1];

up = Simulink.BusElement;
up.Name = 'up';
up.DataType = 'double';
up.Dimensions = [8,1];

down = Simulink.BusElement;
down.Name = 'down';
down.DataType = 'double';
down.Dimensions = [8,1];

right = Simulink.BusElement;
right.Name = 'right';
right.DataType = 'double';
right.Dimensions = [8,1];

left = Simulink.BusElement;
left.Name = 'left';
left.DataType = 'double';
left.Dimensions = [8,1];

pitchUp = Simulink.BusElement;
pitchUp.Name = 'pitchUp';
pitchUp.DataType = 'double';
pitchUp.Dimensions = [8,1];

pitchDown = Simulink.BusElement;
pitchDown.Name = 'pitchDown';
pitchDown.DataType = 'double';
pitchDown.Dimensions = [8,1];

yawRight = Simulink.BusElement;
yawRight.Name = 'yawRight';
yawRight.DataType = 'double';
yawRight.Dimensions = [8,1];

yawLeft = Simulink.BusElement;
yawLeft.Name = 'yawLeft';
yawLeft.DataType = 'double';
yawLeft.Dimensions = [8,1];

rollRight = Simulink.BusElement;
rollRight.Name = 'rollRight';
rollRight.DataType = 'double';
rollRight.Dimensions = [8,1];

rollLeft = Simulink.BusElement;
rollLeft.Name = 'rollLeft';
rollLeft.DataType = 'double';
rollLeft.Dimensions = [8,1];

FF_maneuvers_bus = Simulink.Bus;

FF_maneuvers_bus.Elements = [manual, forward, backward, up, down, right,...
    left, pitchUp, pitchDown, yawRight, yawLeft, rollRight, rollLeft];
    
