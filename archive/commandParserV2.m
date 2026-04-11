function [X_u, command_status, this_hold_start_time,...
    time_in_current_hold, idle_X_u] = commandParserV2(X, command,...
    this_hold_start_time, time_in_current_hold, time, idle_X_u)
%{
This function parses the single command passed to the low-level controller
by the executive controller does the following:
1. Provides the waypoint in inertial coordinates to the Cascaded Controller
2. Tracks the hold time and the tolerance around the waypoint.
3. Outputs SUCCESS or RUNNING status to the executive controller.

%}

%{
check the type of command and return idle if the command does match any of
the expected options.
%}
switch command.command_identifier
    case 'drive_to_current_waypoint'
        %unpack the relevant states
        Ri = X(1:3);
        qib = X(4:7);
        Eul = quatToEul(qib);

        %for drive_to_current_waypoint, the command includes Ri_u already
        Ri_u = command.waypoint(1:3);
        %{
        drive_to_current_waypoint has the target attitude as
        body-to-inertial frame Euler angles
        %}
        Eul_u = command.waypoint(4:6); 
        %{
        For all the values that the user said they did not care about using
        the waypoint mask, set the target to whatever the current value of
        that state is.
        %}
        Ri_u = Ri_u.*command.waypoint_mask(1:3) +...
            Ri.*(~command.waypoint_mask(1:3));
        Eul_u = Eul_u.*command.waypoint_mask(4:6) +...
            Eul.*(~command.waypoint_mask(4:6));
        qib_u = eulToQuat(Eul_u);
        
        %{
        for drive_to_current_waypoint the target angular and linear
        velocity once the waypoint has been reached is zero.
        %}
        dRi_u = zeros(3,1);
        wb_u = zeros(3,1);

        % Pack up the target state
        X_u = [Ri_u; qib_u; dRi_u; wb_u];

        % Calculate the errors and use them to update the hold_time
        qib_e = quatError(qib, qib_u);
        Eul_e = quatToEul(qib_e);
        Ri_e = Ri_u - Ri;

        % Put Eul_e in degrees for comparison with the tolerances
        Eul_e_deg = Eul_e.*(180/pi);

        within_tol_mask = (abs([Ri_e;Eul_e_deg]) <= command.waypoint_tolerances);
        
        if(~ismember(within_tol_mask, false) && isEqual(time_in_current_hold, 0))
            %{
            If all states are within tolerances and the
            time_in_current_hold is zero, that means we just got within
            tolerance and need to set this_hold_start_time
            %}
            this_hold_start_time = time;
            time_in_current_hold = 1e-3; %offset this slightly from zero to avoid getting stuck in a loop here
            command_status = uint8('RUNN'); %say that status is running still
        elseif(~ismember(within_tol_mask, false) && (time_in_current_hold > 0) && (time_in_current_hold < command.hold_time))
            %{
            If all the states are within tolerance and the
            time_in_current_hold is not zero but less than the hold_time, 
            that means we are still counting up the time_in_current_hold so
            we should update it.
            %}
            time_in_current_hold = time - this_hold_start_time;
            command_status = uint8('RUNN');
        elseif(~ismember(within_tol_mask, false) && (time_in_current_hold >= command.hold_time))
            %{
            If all the states are within tolerance and the
            time_in_current_hold is greater than the hold_time, we have
            succeeded.
            %}
            time_in_current_hold = time - this_hold_start_time;
            command_status = uint8('SUCC');
        else
            % We must still be trying to reach our waypoint
            command_status = uint8('RUNN');
        end
    otherwise
        %do stuff for idle
        %{
        If we just got to idle, check our current position and yaw and use
        them as the waypoint forever. Always output running. Use the
        hold_timer in this case to check whether we just got into idle.
        %}
        Ri = X(1:3);
        qib = X(4:7);
        Eul = quatToEul(qib);
        if(isequal(time_in_current_hold, 0))
            Ri_u = Ri;
            Eul_u = [0;0;Eul(3)];
            qib_u = eulToQuat(Eul_u);
            X_u = [Ri_u; qib_u; zeros(3,1); zeros(3,1)];
            idle_X_u = X_u;
            time_in_current_hold = 1e-3;
            this_hold_start_time = time;
        else
            X_u = idle_X_u;
            time_in_current_hold = time - this_hold_start_time;
        end
            
end