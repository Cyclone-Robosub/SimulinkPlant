function [Eul_error, pos_error, FF_cmd,hold_timer_end_time] = maneuverPlanner(WP,X,hold_timer_end_time,t,maneuverPlannerData)

%{
This function inputs the waypoint and current state and plans maneuvers for
the robot in hybrid mode.

In hybrid mode the robot holds an angle setpoint while a forward set is
applied.
%}

X = X(:);
WP = WP(:);

% Pre-allocate
forward_intensity = 0;

% Extract the position and angle aypoint
R_wp = WP(1:3);
Eul_wp = WP(4:6);

% Extract the position and angle error
R_i = X(1:3);
qib = X(4:7);
Eul = quatToEul(qib);

% Unpack maneuverPlannerData
ang_tol = maneuverPlannerData.ang_tol; % angle tolerance for holding angle setpoints
trans_tol = maneuverPlannerData.trans_tol; % transition tolerance from hybrid to 6dof mode
hold_duration = maneuverPlannerData.hold_duration;

% Maneuver logic
ang_error = Eul_wp - Eul;
pos_error = R_wp - R_i;

if(norm(pos_error)>=trans_tol) % If manny is far from the waypoint
    qib_target = getIntermediateAngleWP(R_wp,R_i); % Use the intermediate angle wp
    Eul_target = quatToEul(qib_target);
    pos_error = zeros(3,1);
    Eul_error = Eul_wp - Eul_target;
    
    if(max(abs(ang_error)) >= ang_tol) %If manny is not pointed the right direction
        hold_timer_end_time = t + hold_duration; %reset the hold timer
        forward_intensity = 0; % Don't drive forward

    else % If manny is pointing in the right direction
        if(t >= hold_timer_end_time) % If the hold timer has not elapsed
            forward_intensity = 0; % Don't drive forward yet
        else % If the hold timer has elapsed
            forward_intensity = 1; % Drive forward
        end
    end
else % Manny is close to the waypoint, use the normal angle error
    Eul_error = ang_error;
end

% Generate the forward set command for FFCmdToForce
FF_cmd = [1,1,forward_intensity,0];





end