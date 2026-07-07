function [X_u, cmd_status,hold_timer_out,cmd_hold_time, idle_wp_out, mission_is_started_flag] = commandExecuter(t, cmd, X, action_id, driving_yaw_target,new_cmd_reset, mission_is_started_flag);
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

%unpack current states from X (class X_bus)
Eul = X.Eul;
yaw = Eul(3);
Ri = X.Ri;
dRi = X.dRi;
wb = X.dRb;


%initialize the persistent variables
persistent hold_timer_start_time
persistent idle_wp
persistent cmd_specific_wp
persistent prior_action_id

%{
idle_wp is the value the controller will go to in the following
circumstances: 
1. The user indicates using the cmd.wp_mask that certain
states are free.
2. An unknown command is received.
3. A command to idle is received.

idle_wp is set whenever the command resets to the robot's current position
and current yaw, with a roll and pitch of zero. It also gets reset whenever
the robot enters "driving" mode in the GuidanceLaw, which prevents the
robot from rotating unnecessarily after entering settling mode where the wp
mask does not control position.

cmd_specific_wp is used for commands that need to generate a waypoint
different than what is stored in cmd.wp. This includes 
1. Far field position targets for SSFF maneuvers.
2. Body-relative waypoints rotated to the inertial frame for distance tricks.
3. Body-relative waypoints rotated to the inertial frame for positioning
relative to objects.

cmd_specific_wp is typically set by the commandExecuter when new_cmd_reset
occurs, but some command/trick types may set it more frequently. In general
we want to minimize the number of times we set this to improve stability
and clarity. 

%}


%% Manage Idle Waypoint
%initial states for persistent variables
if isempty(hold_timer_start_time)
    hold_timer_start_time = t;
end
if isempty(idle_wp)
    idle_wp = [Ri;0;0;yaw];
end
if isempty(cmd_specific_wp)
    cmd_specific_wp = idle_wp;
end
if isempty(prior_action_id)
    prior_action_id = 0;
end

%update the idle waypoint based on action_id & new_cmd_reset
DRIVING_ACTION_ID = 2;
if((action_id == DRIVING_ACTION_ID) && (prior_action_id ~= DRIVING_ACTION_ID))
    %update the yaw to match what the guidance law wants
    idle_wp(6) = driving_yaw_target;
end
if(new_cmd_reset)
    % idle_wp = [Ri;0;0;yaw];
    idle_wp = [0;0;0;0;0;yaw];
end

%pass to next timestep
prior_action_id = action_id;

%Reset the persistant variables used to execute commands if new_cmd_reset
if(new_cmd_reset)
    hold_timer_start_time = t;
    prior_action_id = 0;

    fprintf("%.2f: Working on command %s with trick %s.\n",t, char(cmd.cmd_id), char(cmd.trick_id));
end
%in any other case, the idle_waypoint is not reset


%% Switch Command Types
switch char(cmd.cmd_id) %case must match exactly with importMission.m

    case 'drv_to_world_wp_' 
        %drive between waypoints defined in the inertial frame
        [cmd_status, hold_timer, X_u, hold_timer_start_time] = ...
            executeDriveToWorldWaypoint(cmd, idle_wp, X,...
            hold_timer_start_time, t);

        %cmd_specific_wp is unused for this maneuver, so just make it idle
        cmd_specific_wp = idle_wp;

    case 'duration_trick__'
        %do a trick that lasts for a specific duration
        [cmd_status, hold_timer, X_u, hold_timer_start_time, cmd_specific_wp] = ...
            executeDurationTrick(cmd, idle_wp, X, hold_timer_start_time,...
            t, new_cmd_reset, cmd_specific_wp);
        
    case 'idle____________'
        %if we are not in a known command or are idle, just use idle_wp
        X_u = [idle_wp(1:3); eulToQuat(idle_wp(4:6)); zeros(3,1);...
            zeros(3,1)];
        hold_timer_start_time = t; 
        hold_timer = 0;
        cmd_status = int8('RUNN');
        mission_is_started_flag = false;
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



end %executeCommand
