%%Struct for KP collection

%Boolean to toggle an exact perspective vs. a range of random 
KP_Params.doExactPerspective = false;

%Exact Perspective Parameters (Relative to gate)
KP_Params.exactDistance = 400;
KP_Params.exactTheta =  3 * pi / 4;
KP_Params.exactPhi = pi / 4;

%Range Parameters
KP_Params.pitchMin = - pi / 4;
KP_Params.pitchMax = 0;
KP_Params.yaw = 0;
KP_Params.yawRadius = pi/4;
KP_Params.distance = 400;
KP_Params.doReflect = true;
KP_Params.N = 400;         % Amount of points in fibonacci lattice