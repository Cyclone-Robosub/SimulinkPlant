function m_R = getRotationMatrix(orientation)
    %Roll Matrix:
    RM = getRollMatrix(orientation(1));

    %Pitch Matrix:
    PM = getPitchMatrix(orientation(2));

    %Yaw Matrix:
    YM = getYawMatrix(orientation(3));
    %Matrix Computed in Yaw => Pitch => Roll
    m_R = RM*PM*YM;
end

function rollM = getRollMatrix(roll)
    rollM = [1 0 0 0; 0 cos(roll) -sin(roll) 0; 0 sin(roll) cos(roll) 0; 0 0 0 1];
end
%pitch rotation matrix function.
function pitchM = getPitchMatrix(pitch)
    pitchM = [cos(pitch) 0 sin(pitch) 0; 0 1 0 0; -sin(pitch) 0 cos(pitch) 0; 0 0 0 1];
end

%yaw rotation matrix function.
function yawM = getYawMatrix(yaw)
    yawM = [cos(yaw) -sin(yaw) 0 0; sin(yaw) cos(yaw) 0 0; 0 0 1 0; 0 0 0 1];
end