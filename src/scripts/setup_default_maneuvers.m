

%sets up a maneuver (tuned for sim)
forward = maneuver(FT_wrench,MT_wrench,[1 0 0 0 0 0]); %1
forward = forward.setCorrectionFM([0 0 -1 0 0 0],.01);

backward = maneuver(FT_wrench,MT_wrench,[-1 0 0 0 0 0]); %2
backward = backward.setCorrectionFM([0 0 1 0 0 0],-.008);

up = maneuver(FT_wrench,MT_wrench,[0 0 -1 0 0 0]); %3

down = maneuver(FT_wrench,MT_wrench,[0 0 1 0 0 0]); %4

left = maneuver(FT_wrench,MT_wrench,[0 -1 0 0 0 0]); %5
%not gonna bother tuning this it sucks

right = maneuver(FT_wrench,MT_wrench,[0 1 0 0 0 0]); %6
%not gonna bother tuning this sucks

yawLeft = maneuver(FT_wrench,MT_wrench,[0 0 0 0 0 -1]); %7

yawRight = maneuver(FT_wrench,MT_wrench,[0 0 0 0 0 1]); %8

pitchUp = maneuver(FT_wrench,MT_wrench,[0 0 0 0 1 0]); %9

pitchDown = maneuver(FT_wrench,MT_wrench,[0 0 0 0 -1 0]); %10

rollLeft = maneuver(FT_wrench,MT_wrench,[0 0 0 -1 0 0]); %11

rollRight = maneuver(FT_wrench,MT_wrench,[0 0 0 1 0 0]); %12

%masks to pass into simulink
masks = zeros(8,12);
masks(:,1) = forward.getFT_list();
masks(:,2) = backward.getFT_list();
masks(:,3) = up.getFT_list();
masks(:,4) = down.getFT_list();
masks(:,5) = left.getFT_list();
masks(:,6) = right.getFT_list();
masks(:,7) = yawLeft.getFT_list();
masks(:,8) = yawRight.getFT_list();
masks(:,9) = pitchUp.getFT_list();
masks(:,10) = pitchDown.getFT_list();
masks(:,11) = rollLeft.getFT_list();
masks(:,12) = rollRight.getFT_list();








