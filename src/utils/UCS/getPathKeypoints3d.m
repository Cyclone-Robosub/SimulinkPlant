function kpList3d = getPathKeypoints3d(pose)
    p0 = [-44 -7 -1.5 1];
    p1 = [-44 7 -1.5 1];
    p2 = [44 -7 -1.5 1];
    p3 = [44 7 -1.5 1];
    m_R = getRotationMatrix(pose(4:6));
    gate_R = [pose(1:3), 0];
    kp0 = transpose(m_R * p0(:)) + gate_R;
    kp1 = transpose(m_R * p1(:)) + gate_R;
    kp2 = transpose(m_R * p2(:)) + gate_R;
    kp3 = transpose(m_R * p3(:)) + gate_R;
    kpList3d = [kp0; kp1; kp2; kp3;];
end