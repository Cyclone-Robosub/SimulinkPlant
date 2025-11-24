[R_error_out,Eul_error_out,hold_end_time_out,current_hold_time,intermediate_error_set_out] = ...
    maneuverPlanner(R_error,Eul_error,hold_end_time_in,current_hold_time,time,intermediate_error_set_in);

%{
This function inputs the state error in position and euler angle and edits
the values fed to the controller to set the order in which maneuvers are
performed. It also impliments a hold at the end of each maneuver so the
vehicle stabilizes before continuing. The order is as follows.

1. Correct Pitch
2. Correct Roll
3. Choose Target Yaw
4. Correct Z
5. Correct X and Y
6. Correct Yaw

%}

% Check if the vehicle is still at a hold timer, 

