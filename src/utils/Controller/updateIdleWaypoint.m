function idle_wp = updateIdleWaypoint(action_id, prior_action_id, idle_wp, driving_yaw_target, X)
%stuff to set idle_wp based on action_id goes here
TURNING = 1;
DRIVING = 2;
% SETTLING = 3;

if(action_id == TURNING && prior_action_id ~= TURNING)
    %if we transitioned from anything to turning
    %this is used to hold a constant position while turning
    idle_wp(1:3) = X.Ri;

elseif(action_id == DRIVING && prior_action_id ~= DRIVING)
    %if we transitioned from anything to turning
    %this is used to hold a constant position while turning
    idle_wp(1:3) = X.Ri;
    idle_wp(4:6) = [0;0;driving_yaw_target];
end
end
