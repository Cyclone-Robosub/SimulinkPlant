%%Struct for KP collection

%Boolean to toggle an exact perspective vs. a range of random 
KP_Params.doExactPerspective = 1;

%Exact Perspective Parameters (Relative to gate)
KP_Params.exactR = [-200 0 0];

%Range Parameters
KP_Params.thetaMin = -pi/4;
KP_Params.thetaMax = pi/4;
KP_Params.psiMin = 0;
KP_Params.psiMax = pi/4;
KP_Params.distance = 400;
KP_Params.N = 400;         % Amount of points in fibonacci lattice