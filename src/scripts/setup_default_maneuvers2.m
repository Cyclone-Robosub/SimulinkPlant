manual = maneuver2(0,0,FT_wrench,MT_wrench,"manual");
manual = manual.setID(13);
manual = manual.setMaxManeuverForce(10);
manual = manual.setFTList([0 0 0 0 0 0 0 0]);


forward = maneuver2(0,0,FT_wrench,MT_wrench,"forward");
forward = forward.setID(1);
forward = forward.setMaxManeuverForce(20); %max force of one thruster
forward = forward.setFTList(10.*[0 0 0 0 1 -1 1 -1]); %target force for this maneuver
% forward = forward.setForce([10 0 0 0 0 0])
forward = forward.addForce([0 0 -1 0 -2.4 .03]);

backward = maneuver2(0,0,FT_wrench,MT_wrench,"backward");
backward = backward.setID(2);
backward = backward.setMaxManeuverForce(20); %max force of one thruster
backward = backward.setForce(10.*[-1 0 0 0 0 0]); %target force for this maneuver
backward = backward.addForce([0 0 -1.01 0.01 .07 .01]);

up = maneuver2(0,0,FT_wrench,MT_wrench,"up");
up = up.setID(3);
up = up.setMaxManeuverForce(20); %max force of one thruster
up = up.setForce(10.*[0 0 -1 0 0 0]); %target force for this maneuver

down = maneuver2(0,0,FT_wrench,MT_wrench,"down");
down = down.setID(4);
down = down.setMaxManeuverForce(20); %max force of one thruster
down = down.setForce(10.*[0 0 1 0 0 0]); %target force for this maneuver
down = down.addForce([0 0 0 .014 0 0]);

right = maneuver2(0,0,FT_wrench,MT_wrench,"right");
right = right.setID(5);
right = right.setMaxManeuverForce(20); %max force of one thruster
right = right.setForce(10.*[0 1 0 0 0 0]); %target force for this maneuver
right = right.addForce([0.65 0 -0.65 -0.0 0.06 .0]);

left = maneuver2(0,0,FT_wrench,MT_wrench,"left");
left = left.setID(6);
left = left.setMaxManeuverForce(20); %max force of one thruster
left = left.setForce(10.*[0 -1 0 0 0 0]); %target force for this maneuver
left = left.addForce([0.85 0 -0.85 -0.014 .0715 0]);

pitchUp = maneuver2(0,0,FT_wrench,MT_wrench,"pitchUp");
pitchUp = pitchUp.setID(7);
pitchUp = pitchUp.setMaxManeuverForce(20); %max force of one thruster
pitchUp = pitchUp.setForce(10.*[0 0 0 0 1 0]); %target force for this maneuver
pitchUp = pitchUp.addForce([0 0 -.8 0 0 0]);

pitchDown = maneuver2(0,0,FT_wrench,MT_wrench,"pitchDown");
pitchDown = pitchDown.setID(8);
pitchDown = pitchDown.setMaxManeuverForce(20); %max force of one thruster
pitchDown = pitchDown.setForce(10.*[0 0 0 0 -1 0]); %target force for this maneuver
pitchDown = pitchDown.addForce([0 0 -.8 0 0 0]);

yawRight = maneuver2(0,0,FT_wrench,MT_wrench,"yawRight");
yawRight = yawRight.setID(9);
yawRight = yawRight.setMaxManeuverForce(20); %max force of one thruster
yawRight = yawRight.setForce(10.*[0 0 0 0 0 1]); %target force for this maneuver
yawRight = yawRight.addForce([.95 0 -1.58 -0.01 0.01 0]);


yawLeft = maneuver2(0,0,FT_wrench,MT_wrench,"yawLeft");
yawLeft = yawLeft.setID(10);
yawLeft = yawLeft.setMaxManeuverForce(20); %max force of one thruster
yawLeft = yawLeft.setForce(10.*[0 0 0 0 0 -1]); %target force for this maneuver
yawLeft = yawLeft.addForce([.979 0 -1.45 0 0 0]);

rollRight = maneuver2(0,0,FT_wrench,MT_wrench,"rollRight");
rollRight = rollRight.setID(11);
rollRight = rollRight.setMaxManeuverForce(20); %max force of one thruster
rollRight = rollRight.setForce(10.*[0 0 0 1 0 0]); %target force for this maneuver
rollRight = rollRight.addForce([0 0 -2 0 0 0]);

rollLeft = maneuver2(0,0,FT_wrench,MT_wrench,"rollLeft");
rollLeft = rollLeft.setID(12);
rollLeft = rollLeft.setMaxManeuverForce(20); %max force of one thruster
rollLeft = rollLeft.setForce(10.*[0 0 0 -1 0 0]); %target force for this maneuver
rollLeft = rollLeft.addForce([0 0 -1.7 0 0 0]);

maneuver_instances = {manual, forward, backward, up, down, right, left,...
    pitchUp, pitchDown, rollRight, rollLeft, yawRight, yawLeft};

%cell array of maneuver structures to give Simulink
defined_maneuvers = zeros(length(maneuver_instances),10);
for k = 1:length(maneuver_instances)
    defined_maneuvers(k,:) = maneuver_instances{k}.getManeuverMatrix;
end