function [output_mask] = joyToManeuver(joy,masks)
%{
This function uses maneuver masks to map joystick inputs to maneuvers.

joy = [X,Y,Pitch,Yaw,Rise,Sink]
%}

%enforce column joy
joy = joy(:); %6x1

fwd_mask = masks(:,1);
pitch_mask = masks(:,9);
right_mask = masks(:,6);
up_mask = masks(:,3);
yaw_mask = masks(:,8);
down_mask = masks(:,4);
joy_masks = [fwd_mask,right_mask,pitch_mask,yaw_mask,up_mask,down_mask]; %8x6

output_mask = (joy_masks*joy)'; %1x8

%normalize
output_mask = output_mask./(max(abs(output_mask)));

%get force command list
FT_cmd_list = thrusterMaskToForce(thruster_mask,max_thruster_force); 

end