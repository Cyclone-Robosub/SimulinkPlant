function [X_u, cmd_status,hold_timer_out,cmd_hold_time, idle_wp_out] = commandExecuter(t, cmd, X, action_id, driving_yaw_target, rst)
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

%unpack current states
Eul = X.Eul;
yaw = Eul(3);
Ri = X.Ri;
dRi = X.dRi;
wb = X.dRb;


%initialize the persistent variables
persistent hold_timer_start_time
persistent idle_wp
persistent prior_action_id
persistent prior_cmd 

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


%% Manage Idle Waypoint
%initial states for persistent variables
if isempty(hold_timer_start_time)
    hold_timer_start_time = t;
end
if isempty(idle_wp)
    idle_wp = [Ri;0;0;yaw];
end

if isempty(prior_action_id)
    prior_action_id = 0;
end

if isempty(prior_cmd)
    prior_cmd = struct('cmd_id',int8('________________'),'wp',zeros(6,1),...
        'wp_mask',zeros(6,1),'wp_tol',zeros(6,1),'hold_time',999,...
        'obj_id',int8('________________'),'conf',0,'trick_id',int8('________________'),...
        'exec_timeout',999999);
end


%update the idle waypoint based on action_id
idle_wp = updateIdleWaypoint(action_id, prior_action_id, idle_wp,...
    driving_yaw_target, X);

prior_action_id = action_id;

%reset if the command is new
if(~isequal(cmd, prior_cmd))
    fprintf("%.2f, Current Command: %s with Trick ID: %s\n",t, char(cmd.cmd_id), char(cmd.trick_id));
    rst = 1;
end
if(rst)
    hold_timer_start_time = t;
    prior_action_id = 0;
end

prior_cmd = cmd;
%in any other case, the idle_waypoint is not reset
%% Switch Command Types
switch char(cmd.cmd_id) %case must match exactly with importMission.m
    case 'drv_to_world_wp_' 
        %drive between waypoints defined in the inertial frame
        [cmd_status, hold_timer, X_u, hold_timer_start_time] = ...
            executeDriveToWorldWaypoint(cmd, idle_wp, X,...
            hold_timer_start_time, t);
    case 'duration_trick__'
        %do a trick that lasts for a specific duration
        [cmd_status, hold_timer, X_u, hold_timer_start_time] = ...
            executeDurationTrick(cmd, idle_wp, X, hold_timer_start_time,...
            t);
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
