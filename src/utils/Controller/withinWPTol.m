function tf = withinWPTol(X, X_u, cmd)
    %{
    Return true if the vehicle is within the specified tolerance of the
    waypoint. Note, that to prevent uncontrolled behavior, STATES USING THE
    IDLE WAYPOINT ARE ALSO USED TO VALIDATE WITHIN TOLERANCE.
    %}
    Ri = X.Ri;
    qib = X.qib;
    
    R_error = abs(Ri - X_u(1:3));
    quat_error = quatError(qib, X_u(4:7));
    eul_error = abs(quatToEul(quat_error));
    
    
    tf_mask = [R_error;eul_error] < cmd.wp_tol;
    tf = all(tf_mask); 

end %withinWPTol