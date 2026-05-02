function qib_u_out = trickQuaternionModifier(qib_u, cmd, action_id)
%{
This function modifies the robot's target quaternion to perform different
tricks
%}
    %convert quaternion to euler angles
    Eul = quatToEul(qib_u);

    %check if the robot is in driving mode. tricks should only be run in
    %driving mode.
    if(action_id == 2)
        %Check the trick id to decide how to modify the target quaternion
        switch char(cmd.trick_id)
            case 'barrel_roll_____'
                Eul(1) = Eul(1) + 0.1;
                qib_u_out = eulToQuat(Eul);
            otherwise
                qib_u_out = qib_u;
        end
    else
        qib_u_out = qib_u;
    end

end