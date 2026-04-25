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

distance_KP = KP_Params.distance;
N_KP = KP_Params.N;

%% Prop Locations
gate1_Pose = [250 -580 60 0 0 0];
gate_center = gate1_Pose + [0 154 -58 0 0 0];
keyPointsWorld = getGateKeypoints3d(gate1_Pose);
numKeypoints = 4;
background_pose = [...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0];...
    [-10000 -10000 10000 0 0 0]...
    ];

if(KP_Params.backgroundValue > 0)
    KP_Params.doReflect = false;
    background_pose(KP_Params.backgroundValue,:) = gate_center + [30 0 0 0 0 0];
end


%% Simulation Parameters
%simulation duration
tspan = 10;

%Delay (in units of dt_sample) of how long to wait for lighting to calibrate
startDelay_KP = 4; %Needs to be multiples of 2.

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
        distanceAdjusted = distance_KP + (rand(1, "double") - 0.5) * 2 * KP_Params.distanceNoise;
        x = sin(theta) * cos(phi) * distanceAdjusted + gate_center(1);
        y = sin(theta) * sin(phi) * distanceAdjusted + gate_center(2);
        z = cos(theta) * distanceAdjusted + gate_center(3);
        clear distanceAdjusted;
        pose = [x y z (rand(1, "double") - 0.5) * 2*KP_Params.rollNoise (m_Pitch + (rand(1, "double") - 0.5) * 2 * KP_Params.pitchNoise) (m_Yaw + (rand(1, "double") - 0.5) * 2*KP_Params.yawNoise)];
        
        m_YawLine = [cos(m_Yaw) sin(m_Yaw)];
        yawLine_KP = [cos(KP_Params.yaw) sin(KP_Params.yaw)];

        yawDif_Bool = dot(m_YawLine, yawLine_KP) / norm(m_YawLine) / norm(yawLine_KP) >= cos(KP_Params.yawRadius);
        yawDifReflect_Bool = dot(m_YawLine, yawLine_KP) / norm(m_YawLine) / norm(yawLine_KP) <= - cos(KP_Params.yawRadius); 
        
        if (z <= 100 - 20 && z >= -180 + 20 && m_Pitch >= pitchMin_KP && m_Pitch <= pitchMax_KP && (yawDif_Bool || (yawDifReflect_Bool && KP_Params.doReflect) ))
            q = q + 1;
            perspectives(q, :) = pose(:);
        end
    end
    perspectives = single(perspectives);
    tspan = dt_sample * (q + startDelay_KP + 2)*2;
end

numPerspectives = q;
disp("Number of Perspectives:")
disp(numPerspectives)
clear i q k c x y z theta phi m_Pitch m_Yaw m_YawLine yawLine_KP pose yawDif_Bool yawDifReflect_Bool distance_KP;