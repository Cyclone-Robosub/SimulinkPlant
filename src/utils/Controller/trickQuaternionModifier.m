function qib_u_out = trickQuaternionModifier(qib_u, cmd, action_id)
%{
This function modifies the robot's target quaternion to perform different
tricks
%}

    %Check if the robot is in driving mode
    if(action_id == 2)
        %TODO: Add switch statement to check cmd id
        qib_u_out = qib_u;
    else
        qib_u_out = qib_u;
    end

end