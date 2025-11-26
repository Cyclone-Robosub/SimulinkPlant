clear forward backward up down left right yawLeft yawRight pitchUp pitchDown rollLeft rollRight

%sets up a maneuver (tuned for sim)
forward = maneuver(FT_wrench,MT_wrench,[1 0 0 0 0 0]); %1
forward = forward.setCorrectionFM([0 0 -1 0 0 0],0.029);

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
masks(:,1) = forward.total_mask;
masks(:,2) = backward.total_mask;
masks(:,3) = up.total_mask;
masks(:,4) = down.total_mask;
masks(:,5) = left.total_mask;
masks(:,6) = right.total_mask;
masks(:,7) = yawLeft.total_mask;
masks(:,8) = yawRight.total_mask;
masks(:,9) = pitchUp.total_mask;
masks(:,10) = pitchDown.total_mask;
masks(:,11) = rollLeft.total_mask;
masks(:,12) = rollRight.total_mask;








