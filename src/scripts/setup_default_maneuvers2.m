manual = maneuver2(0,0,FT_wrench,MT_wrench,"manual");
manual = manual.setID(13);
manual = manual.setMaxManeuverForce(2);
manual = manual.setFTList([1 1 1 1 0 0 0 0]);
%manual = manual.setForce(3*[0 1 0 0 0 0]);

forward = maneuver2(0,0,FT_wrench,MT_wrench,"forward");
forward = forward.setID(1);
forward = forward.setMaxManeuverForce(40); %max force of one thruster
forward = forward.setFTList(20*[0 0 0 0 1 -1 1 -1]); %target force for this maneuver
%forward = forward.addForce([0 0 -.5 0 .2 -0.5]);
forward = forward.addFTList([-.4 0.4 0 0 ...
                             -1.8 0 -1.8 0]);
forward = forward.setFTList(10*[0 0 0 0 1 -1 1 -1]); %target force for this maneuver
% forward = forward.setForce([10 0 0 0 0 0])
forward = forward.addForce([0 0 -1 0 -2.4 .03]);


backward = maneuver2(0,0,FT_wrench,MT_wrench,"backward");
backward = backward.setID(2);


backward = maneuver2(0,0,FT_wrench,MT_wrench,"backward");
backward = backward.setID(2);
%backward = backward.setMaxManeuverForce(10); %max force of one thruster
%backward = backward.setForce([0 0 0 0 0 -2]); %target force for this maneuver
backward = backward.setMaxManeuverForce(10); %max force of one thruster
backward = backward.setForce([0 0 0 0 0 2]); %target force for this maneuver

up = maneuver2(0,0,FT_wrench,MT_wrench,"up");
up = up.setID(3);
up = up.setMaxManeuverForce(40); %max force of one thruster
up = up.setForce(5*[0 0 -1 0 0 0]); %target force for this maneuver

down = maneuver2(0,0,FT_wrench,MT_wrench,"down");
down = down.setID(4);
down = down.setMaxManeuverForce(20); %max force of one thruster
down = down.setForce(10*[0 0 1 0 0 0]); %target force for this maneuver
down = down.addForce(10*[1 0 0 0 0 0]);

right = maneuver2(0,0,FT_wrench,MT_wrench,"right");
right = right.setID(5);
right = right.setMaxManeuverForce(10); %max force of one thruster
right = right.setForce([0 1 0 0 0 0]); %target force for this maneuver

left = maneuver2(0,0,FT_wrench,MT_wrench,"left");
left = left.setID(6);
left = left.setMaxManeuverForce(10); %max force of one thruster
left = left.setForce([0 0 -1 0 0 0]); %target force for this maneuver

pitchUp = maneuver2(0,0,FT_wrench,MT_wrench,"pitchUp");
pitchUp = pitchUp.setID(7);
pitchUp = pitchUp.setMaxManeuverForce(10); %max force of one thruster
pitchUp = pitchUp.setForce([0 0 0 0 1 0]); %target force for this maneuver

pitchDown = maneuver2(0,0,FT_wrench,MT_wrench,"pitchDown");
pitchDown = pitchDown.setID(8);
pitchDown = pitchDown.setMaxManeuverForce(10); %max force of one thruster
pitchDown = pitchDown.setForce([0 0 0 0 -1 0]); %target force for this maneuver

yawRight = maneuver2(0,0,FT_wrench,MT_wrench,"yawRight");
yawRight = yawRight.setID(9);
yawRight = yawRight.setMaxManeuverForce(10); %max force of one thruster
yawRight = yawRight.setForce(5*[0 0 0 0 0 1]); %target force for this maneuver

yawLeft = maneuver2(0,0,FT_wrench,MT_wrench,"yawLeft");
yawLeft = yawLeft.setID(10);
yawLeft = yawLeft.setMaxManeuverForce(40); %max force of one thruster
yawLeft = yawLeft.setForce(40*[0 0 0 0 0 -1]); %target force for this maneuver

rollRight = maneuver2(0,0,FT_wrench,MT_wrench,"rollRight");
rollRight = rollRight.setID(11);
rollRight = rollRight.setMaxManeuverForce(10); %max force of one thruster
rollRight = rollRight.setForce(10*[0 0 0 1 0 0]); %target force for this maneuver

rollLeft = maneuver2(0,0,FT_wrench,MT_wrench,"rollLeft");
rollLeft = rollLeft.setID(12);
rollLeft = rollLeft.setMaxManeuverForce(10); %max force of one thruster
rollLeft = rollLeft.setForce([0 0 0 -1 0 0]); %target force for this maneuver

maneuver_instances = {manual, forward, backward, up, down, right, left,...
    pitchUp, pitchDown, rollRight, rollLeft, yawRight, yawLeft};

%cell array of maneuver structures to give Simulink
defined_maneuvers = zeros(length(maneuver_instances),10);
for k = 1:length(maneuver_instances)
    defined_maneuvers(k,:) = maneuver_instances{k}.getManeuverMatrix;
end
