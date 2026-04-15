function kpList3d = getGateKeypoints3d(gate_Pose)
    p0 = [0 0 116];
    p1 = [0 0 0];
    p2 = [0 307 116];
    p3 = [0 307 0];
    m_R = getRotationMatrix(gate_Pose(4:6));
    m_R = m_R(1:3, 1:3);
    kp0 = p0 + gate_Pose(1:3);
    kp1 = transpose(m_R * transpose(p1)) + gate_Pose(1:3);
    kp2 = transpose(m_R * transpose(p2)) + gate_Pose(1:3);
    kp3 = transpose(m_R * transpose(p3)) + gate_Pose(1:3);
    kpList3d = [kp0(:) kp1(:) kp2(:) kp3(:)];
end