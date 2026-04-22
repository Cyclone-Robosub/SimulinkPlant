%% Booleans 

%to toggle an exact perspective vs. a range of random 
doExactPerspective = KP_Params.doExactPerspective;

%% Exact Perspective Parameters (Relative to gate)
exactDistance_KP = KP_Params.exactDistance;
exactTheta_KP = KP_Params.exactTheta;
exactPhi_KP = KP_Params.exactPhi;

%% Range Parameters
pitchMin_KP = KP_Params.pitchMin;
pitchMax_KP = KP_Params.pitchMax;
yawLine_KP = [cos(KP_Params.yaw) sin(KP_Params.yaw)];

distance_KP = KP_Params.distance;
N_KP = KP_Params.N;

%% Prop Locations
gate1_Pose = [250 -580 100 0 0 0];
gate_center = [250 -426 42 0 0 0];
keyPointsWorld = getGateKeypoints3d(gate1_Pose);
numKeypoints = 4;

%% Simulation Parameters
%simulation duration
tspan = 10;

%Delay (in units of dt_sample) of how long to wait for lighting to calibrate
startDelay_KP = 4;

%timesteps for various simulation components
dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/30, dt_sim); %data saving timestep
dt_sample = 0.03;

%% Generate Spherical Array of Points for Manatee Perspectives
k = (1 + sqrt(5)) / 2;
c = rand(1, "double") / 2;
perspectives = zeros(N_KP, 6);
q = 0;

if doExactPerspective == false
    for i = 0:(N_KP-1)
        x = mod(i / k, 1);
        y = i / (N_KP - 1 + (2 * c));
        theta = acos(1 - 2*y);
        phi = 2*pi*x;
        m_Pitch = (pi / 2 - theta);
        m_Yaw = (phi - pi);
        
        x = sin(theta) * cos(phi) * distance_KP + gate_center(1);
        y = sin(theta) * sin(phi) * distance_KP + gate_center(2);
        z = cos(theta) * distance_KP + gate_center(3);
        
        pose = [x y z 0 m_Pitch m_Yaw];
        
        yawDif = acos( ( yawLine_KP(1) * pose(1) + yawLine_KP(2) * pose(2) ) / (yawLine_KP(1)^2 + yawLine_KP(2)^2)^0.5 / (pose(1)^2 + pose(2)^2)^0.5 );
        yawDifReflect = acos( ( - yawLine_KP(1) * pose(1) - yawLine_KP(2) * pose(2) ) / (yawLine_KP(1)^2 + yawLine_KP(2)^2)^0.5 / (pose(1)^2 + pose(2)^2)^0.5 ); 
        
        if (z <= 100 && z >= -180 && m_Pitch >= pitchMin_KP && m_Pitch <= pitchMax_KP && (yawDif <= KP_Params.yawRadius || (yawDifReflect <= KP_Params.yawRadius && KP_Params.doReflect) ))
            q = q + 1;
            perspectives(q, :) = pose(:);
        end
    end
    perspectives = single(perspectives);
    tspan = dt_sample * (q + startDelay_KP + 2);
end

numPerspectives = q;
disp("Number of Perspectives:")
disp(numPerspectives)
clear i q k c x y z theta phi m_Pitch m_Yaw yawLine_KP pose yawDif yawDifReflect distance_KP;