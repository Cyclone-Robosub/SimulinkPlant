function qib_u_out = quatInjector(cmd, qib_u, action_id, X, eul_sp_inject, overwrite_state_setpoint_flag)

Eul = X.Eul;

if(action_id == 2 || action_id == 1)
    switch char(cmd.trick_id)
        case 'barrel_roll_____'
            Eul(1) = Eul(1) + 3.10;
            qib_u_out = eulToQuat(Eul);
        otherwise
            qib_u_out = qib_u;
    end
else
    qib_u_out = qib_u;
end

if(overwrite_state_setpoint_flag)
    qib_u_out = eulToQuat(eul_sp_inject);
end

