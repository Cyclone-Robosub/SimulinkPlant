function tf = withinWPTol(X, X_u, cmd)
    %Returns true if all controlled states are within their tolerance,
    %false otherwise

    %TODO - modify this code so it uses the cmd waypoint rotated to the
    %inertial frame for commands that specify the waypoint in the body.
    %Also add handling for commands that do not specify a waypoint. It
    %should also use the
    Ri = X.Ri;
    qib = X.qib;
    
    R_error = abs(Ri - X_u(1:3));
    quat_error = quatError(qib, X_u(4:7));
    eul_error = abs(quatToEul(quat_error));
    
    %{
    return true if ALL the states are within tolerance simultaenously note,
    the wp_tol is still used for states that are driven towards the
    idle_wp.
    %}
    tf_mask = [R_error;eul_error] < cmd.wp_tol;
    tf = all(tf_mask + (~cmd.wp_mask)); %turns the values that are not controlled true


end %withinWPTol