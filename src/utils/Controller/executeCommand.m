function [X_u, cmd_status,hold_timer_out,cmd_hold_time] = executeCommand(t, cmd, X)
    %{
    This function handles a single command at a time from discountExecutive. 
    
    Operation:
    1. Check the type of command based on cmd.cmd_id
    2. Do any analysis required calculate waypoints and/or feedforward commands
    3. Compare the robot's current state to the target state
    4. Output the command status as success, failure*, or running
    
    So far the function only Drive to World Waypoint. Others TODO
    
    Inputs:
        t (double) - the time since the start of the simulation in seconds
        cmd (struct) - structure of command data in the form described in
        setup_cmd_bus.m and defined by importMission.m
        X (13x1 double) - the state vector in the form [Ri; qvector; qscalar...
        ; dRi, wb]
    
    Outputs:
        cmd_status (4x1 int8) - 4 character status cast to an int8. 
        Valid options are "SUCC", "FAIL", and "RUNN" for success, failure, and 
        running.
        X_u (13x1 double) - the target waypoint in the form [Ri_u,
        qvector_u; qscalar_u; zeros(3,1), zeros(3,1)**]
        
        template_command = struct("cmd_id",int8('16characters____'),"wp",...
            zeros(6,1),"wp_mask",zeros(6,1),"wp_tol",zeros(6,1),"hold_time",...
            0,"obj_id",int8('16characters____'),"obj_conf",0,"trick_id",...
            int8('16characters____'),"timeout",0);
    
    *Failure is not triggered timeouts, that is handled by the
    discountExecutive. Instead Failure is reserved for death spiral watchdog or
    failure to spot the target object within the hold-time at the waypoint.
    **Nominal target velocity is always zero, but the cascade controller can
    set velocity downstream to drive to waypoints.
    
    %}
    %initialize X_u to X
    X_u = X;

    %unpack current states
    Eul = quatToEul(X(4:7));
    yaw = Eul(3);
    Ri = X(1:3);
    dRi = X(8:10);
    wb = X(11:13);

    %initialize the persistent variables
    persistent hold_timer_start_time
    persistent idle_wp %might get ride of idle_wp in discountExecutive
    
    
    %initial states for persistent variables
    if isempty(hold_timer_start_time)
        hold_timer_start_time = t;
    end
    if isempty(idle_wp)
        idle_wp = [X(1:3);0;0;yaw];
        %sets the idle waypoint to the current position and yaw, zero roll,
        %pitch, and velocity. The position and yaw in idle waypoint gets
        %reset every time a command succeeds or fails but persists while
        %running.
    end
    

    switch char(cmd.cmd_id)
        case 'drv_to_world_wp_'
            %find target states, setting uncontrolled states to the idle wp

            %target quat
            Eul_u = idle_wp(4:6).*(~cmd.wp_mask(4:6)) + cmd.wp(4:6).*(cmd.wp_mask(4:6));
            qib_u = eulToQuat(Eul_u);

            %target position
            Ri_u = idle_wp(1:3).*(~cmd.wp_mask(1:3)) + cmd.wp(1:3).*(cmd.wp_mask(1:3));
            
            X_u = [Ri_u; qib_u; zeros(3,1); zeros(3,1)];

            %update the hold timer if we are at our waypoint
            if(withinWPTol(X,X_u))
                hold_timer = t - hold_timer_start_time;
            else
                hold_timer_start_time = t;
                hold_timer = 0;
            end

            if(hold_timer >= cmd.hold_time)
                cmd_status = int8('SUCC');
                hold_timer_start_time = t;
                idle_wp = [X(1:3);0;0;yaw];
            else
                cmd_status = int8('RUNN');
            end

           

        otherwise
            X_u = [idle_wp(1:3); eulToQuat(idle_wp(4:6)); zeros(3,1); zeros(3,1)];
            hold_timer_start_time = t;
            hold_timer = 0;
            cmd_status = int8('RUNN');
    end
    
    hold_timer_out = hold_timer;
    cmd_hold_time = cmd.hold_time;

    
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

        tf = all([R_error;eul_error] < cmd.wp_tol);
        



    end


end
