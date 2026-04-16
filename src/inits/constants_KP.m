%% Booleans 

%to toggle an exact perspective vs. a range of random 
doExactPerspective = KP_Params.doExactPerspective;

%% Exact Perspective Parameters (Relative to gate)
exactR = KP_Params.exactR;

%% Range Parameters
thetaMin_KP = KP_Params.thetaMin;
thetaMax_KP = KP_Params.thetaMax;
psiMin_KP = KP_Params.psiMin;
psiMax_KP = KP_Params.psiMax;
distance_KP = KP_Params.distance;
N_KP = KP_Params.N;  

%% Prop Locations
gate1_Pose = [250 -580 100 0 0 0];

%% Simulation Parameters
%simulation duration
tspan = 30;

%timesteps for various simulation components
dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/30, dt_sim); %data saving timestep