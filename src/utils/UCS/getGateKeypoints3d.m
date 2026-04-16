function kpList3d = getGateKeypoints3d(gate_Pose)
    p1 = [0 0 -116 1];
    p0 = [0 0 0 1];
    p2 = [0 307 -116 1];
    p3 = [0 307 0 1];
    m_R = getRotationMatrix(gate_Pose(4:6));
    gate_R = [gate_Pose(1:3), 0];
    kp0 = p0 + gate_R;
    kp1 = transpose(m_R * p1(:)) + gate_R;
    kp2 = transpose(m_R * p2(:)) + gate_R;
    kp3 = transpose(m_R * p3(:)) + gate_R;
    kpList3d = [kp0; kp1; kp2; kp3;];
end