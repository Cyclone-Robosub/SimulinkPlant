%%Struct for KP collection

%Boolean to toggle an exact perspective vs. a range of random 
KP_Params.doExactPerspective = false;

%Exact Perspective Parameters (Relative to gate)
KP_Params.exactDistance = 400;
KP_Params.exactTheta =  pi / 2;
KP_Params.exactPhi = 0;

%Range Parameters
KP_Params.pitchMin = - pi / 4;
KP_Params.pitchMax = pi / 4;
KP_Params.yaw = 0;
KP_Params.yawRadius = pi / 3;
KP_Params.distance = 400;
KP_Params.doReflect = false;
KP_Params.N = 400;         % Amount of points in fibonacci lattice

%Noise Parameters
KP_Params.rollNoise = pi;
KP_Params.pitchNoise = pi / 90;
KP_Params.yawNoise = pi / 60;
KP_Params.distanceNoise = 20;

%Background Parameters
KP_Params.backgroundValue = 1;