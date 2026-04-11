function [FT_cmd_list] = joyToManeuver(joy,masks,max_thruster_force)
%{
This function uses maneuver masks to map joystick inputs to maneuvers.

joy = [X,Y,Rise,Sink,Yaw,Pitch]
%}

%enforce column joy
joy = double(joy(:)); %6x1

fwd_mask = masks(:,1);
pitch_mask = masks(:,9);
right_mask = masks(:,6);
up_mask = masks(:,3);
yaw_mask = masks(:,8);
down_mask = masks(:,4);
joy_masks = [fwd_mask,right_mask,up_mask,down_mask,yaw_mask,pitch_mask]; %8x6

%[fwd_mask,right_mask,up_mask,down_mask,yaw_mask,pitch_mask];

output_mask = (joy_masks*joy)'; %1x8

%normalize
if(max(abs(output_mask))<0.01)
    output_mask = zeros(1,8);
else
    output_mask = output_mask./(max(abs(output_mask)));
end

%get force command list
FT_cmd_list = thrusterMaskToForce(output_mask,max_thruster_force); 

end