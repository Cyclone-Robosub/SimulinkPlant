function [X_u, cmd_status,hold_timer_out,cmd_hold_time, idle_wp_out] = executeCommand(t, cmd, X, action_id, driving_yaw_target)
%{
This function handles a single command at a time from discountExecutive.

Operation: 1. Check the type of command based on cmd.cmd_id 2. Do any
analysis required calculate waypoints and/or feedforward commands 3.
Compare the robot's current state to the target state 4. Output the command
status as success, failure*, or running

So far the function only Drive to World Waypoint. Others TODO

Inputs: t (double) - the time since the start of the simulation in seconds
cmd (struct) - structure of command data in the form described in
setup_cmd_bus.m and defined by importMission.m X (13x1 double) - the state
vector in the form [Ri; qvector; qscalar... ; dRi, wb]

Outputs: cmd_status (4x1 int8) - 4 character status cast to an int8. Valid
options are "SUCC", "FAIL", and "RUNN" for success, failure, and running.
X_u (13x1 double) - the target waypoint in the form [Ri_u, qvector_u;
qscalar_u; zeros(3,1), zeros(3,1)**]
    
Commands are structures with the following fields: cmd.cmd_id cmd.wp
cmd.wp_mask cmd.hold_time cmd.obj_id cmd.conf cmd.trick_id cmd.exec_timeout

*Failure is not triggered by timeouts, that is handled by the
discountExecutive. Instead Failure is reserved for death spiral watchdog or
failure to spot the target object within the hold-time at the waypoint.
**Nominal target velocity is always zero, but the cascade controller can
set velocity downstream to drive to waypoints.

%}

% initialize X_u to X so if none of the branches in this are triggered
% there is still a valid output that causes the robot to stop
X_u = X;

%unpack current states
Eul = quatToEul(X(4:7));
yaw = Eul(3);
Ri = X(1:3);
dRi = X(8:10);
wb = X(11:13);

%initialize the persistent variables
persistent hold_timer_start_time
persistent idle_wp
persistent prior_action_id

%{
idle_wp is the value the controller will go to in the following
circumstances: 1. The user indicates using the cmd.wp_mask that certain
states are free 2. The robot needs a position command to hold while
performing a turn

idle_wp is saved whenever the guidanceLaw in the low-level controller
transitions between "actions", which are turning, driving, and settling.

In the case of turning, the idle waypoint is used to hold position while
turning.

In the case of settling, the idle waypoint is used for any states that are
free based on cmd.wp_mask.
%}



%initial states for persistent variables
if isempty(hold_timer_start_time)
    hold_timer_start_time = t;
end

if isempty(idle_wp)
    idle_wp = [X(1:3);0;0;yaw];
end

if isempty(prior_action_id)
    prior_action_id = 0;
end

%stuff to set idle_wp based on action_id goes here
TURNING = 1;
DRIVING = 2;
SETTLING = 3;

if(action_id == TURNING && prior_action_id ~= TURNING)
    %if we transitioned from anything to turning
    %this is used to hold a constant position while turning
    idle_wp(1:3) = X(1:3);

elseif(action_id == DRIVING && prior_action_id ~= DRIVING)
    %if we transitioned from anything to turning
    %this is used to hold a constant position while turning
    idle_wp(1:3) = X(1:3);
    idle_wp(4:6) = [0;0;driving_yaw_target];
end

prior_action_id = action_id;

%in any other case, the idle_waypoint is not reset

switch char(cmd.cmd_id) %case must match exactly with importMission.m
    case 'drv_to_world_wp_' 
        %find target states, setting uncontrolled states to the idle wp
        %target quat
        Eul_u = idle_wp(4:6).*(~cmd.wp_mask(4:6)) +...
            cmd.wp(4:6).*(cmd.wp_mask(4:6));
    
        %convert to the quaternion
        qib_u = eulToQuat(Eul_u);

        %target position
        Ri_u = idle_wp(1:3).*(~cmd.wp_mask(1:3)) +...
            cmd.wp(1:3).*(cmd.wp_mask(1:3));
        
        %pack up state
        X_u = [Ri_u; qib_u; zeros(3,1); zeros(3,1)];

        %update the hold timer if we are at our waypoint
        if(withinWPTol(X,X_u))
            hold_timer = t - hold_timer_start_time;
        else
            %otherwise keep pushing the start time so the hold timer starts
            %small on the next timestep
            hold_timer_start_time = t;
            hold_timer = 0;
        end
        
        %see if the hold_time has been met so we can return a success
        if(hold_timer >= cmd.hold_time)
            cmd_status = int8('SUCC');
            hold_timer_start_time = t;
            

        else
            %otherwise report that we are still running
            cmd_status = int8('RUNN');
        end

       

    otherwise
        %if we are not in a known command or are idle, just use idle_wp
        X_u = [idle_wp(1:3); eulToQuat(idle_wp(4:6)); zeros(3,1);...
            zeros(3,1)];

        hold_timer_start_time = t;
        hold_timer = 0;

        cmd_status = int8('RUNN');
end %switch

%configure outputs for debugging
hold_timer_out = hold_timer;
cmd_hold_time = cmd.hold_time;
idle_wp_out = idle_wp;

%maintain shape of cmd_status
cmd_status = cmd_status(:);



%helper functions
function tf = withinWPTol(X, X_u)
    %Returns true if all controlled states are within their tolerance,
    %false otherwise

    %TODO - modify this code so it uses the cmd waypoint rotated to the
    %inertial frame for commands that specify the waypoint in the body.
    %Also add handling for commands that do not specify a waypoint. It
    %should also use the

    R_error = abs(X(1:3) - X_u(1:3));
    quat_error = quatError(X(4:7), X_u(4:7));
    eul_error = abs(quatToEul(quat_error));
    
    %{
    return true if ALL the states are within tolerance simultaenously note,
    the wp_tol is still used for states that are driven towards the
    idle_wp.
    %}
    tf_mask = [R_error;eul_error] < cmd.wp_tol;
    tf = all(tf_mask + (~cmd.wp_mask)); %turns the values that are not controlled true


end %withinWPTol


end %executeCommand
