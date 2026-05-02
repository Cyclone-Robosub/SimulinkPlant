function qib_u_out = trickQuatInjector(cmd, qib_u, action_id, X)

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
