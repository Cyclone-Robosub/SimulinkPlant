%% Booleans 

%to toggle an exact perspective vs. a range of random 
doExactPerspective = KP_Params.doExactPerspective;

%Camera Changes
rel_CamPose_L = [40 0 0 0 0 0];
rel_CamPose_L_UCS = rel_CamPose_L*M_WorldToUCS;

%% Exact Perspective Parameters (Relative to gate)
exactDistance_KP = KP_Params.exactDistance;
exactTheta_KP = KP_Params.exactTheta;
exactPhi_KP = KP_Params.exactPhi;

%% Range Parameters
pitchMin_KP = KP_Params.pitchMin;
pitchMax_KP = KP_Params.pitchMax;

distance_KP = KP_Params.distance;
N_KP = KP_Params.N;
gate1_Pose = [0 0 -1000 0 0 0];
searchRescueEmoji_Pose = [100 0 -1000 0 0 0];
surveyRepairEmoji_Pose = [0 0 -1000 0 0 0];
path_Pose = [-100 0 -1000 0 0 0];
prop_Center = [0 0 0 0 0 0];
keyPointsWorld = zeros(4,6);

%% Prop Locations
if(KP_Params.propChoice == "Gate")
    gate1_Pose = [250 -580 18 0 0 0];
    prop_Center = gate1_Pose + [0 154 -58 0 0 0];
    keyPointsWorld = getGateKeypoints3d(gate1_Pose);
elseif(KP_Params.propChoice == "SearchRescueEmoji")
    searchRescueEmoji_Pose = [250 -426 -40 pi/2 0 pi/2];
    prop_Center = searchRescueEmoji_Pose;
    keyPointsWorld = getSearchRescueEmojiKeypoints(searchRescueEmoji_Pose);
elseif(KP_Params.propChoice == "SurveyRepairEmoji")
    surveyRepairEmoji_Pose = [250 -426 -40 pi/2 0 pi/2];
    prop_Center = surveyRepairEmoji_Pose;
    keyPointsWorld = getSurveyRepairEmojiKeypoints(surveyRepairEmoji_Pose);
elseif(KP_Params.propChoice == "Path")
    path_Pose = [250 -426 -40 0 pi/2 0];
    prop_Center = path_Pose;
    keyPointsWorld = getPathKeypoints3d(path_Pose);
else
    fprintf("Unknown propChoice. Valid options:\nPath\nSurveyRepairEmoji\nSearchRescueEmoji\nGate");
    return;
end
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
    background_pose(KP_Params.backgroundValue,:) = prop_Center + [30 0 0 0 0 0];
end

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
        x = sin(theta) * cos(phi) * distanceAdjusted + prop_Center(1) + (rand(1, "double") - 0.5) * 2 * KP_Params.xNoise;
        y = sin(theta) * sin(phi) * distanceAdjusted + prop_Center(2) + (rand(1, "double") - 0.5) * 2 * KP_Params.yNoise;
        z = cos(theta) * distanceAdjusted + prop_Center(3) + (rand(1, "double") - 0.5) * 2 * KP_Params.zNoise;
        clear distanceAdjusted;
        pose = [x y z (rand(1, "double") - 0.5) * 2*KP_Params.rollNoise (m_Pitch + (rand(1, "double") - 0.5) * 2 * KP_Params.pitchNoise) (m_Yaw + (rand(1, "double") - 0.5) * 2*KP_Params.yawNoise)];
        
        m_YawLine = [cos(m_Yaw) sin(m_Yaw)];
        yawLine_KP = [cos(KP_Params.yaw) sin(KP_Params.yaw)];

        yawDif_Bool = dot(m_YawLine, yawLine_KP) / norm(m_YawLine) / norm(yawLine_KP) >= cos(KP_Params.yawRadius);
        yawDifReflect_Bool = dot(m_YawLine, yawLine_KP) / norm(m_YawLine) / norm(yawLine_KP) <= - cos(KP_Params.yawRadius); 
        
        if (z <= ground_Z - 20 && z >= waterLevel_Z + 20 && m_Pitch >= pitchMin_KP && m_Pitch <= pitchMax_KP && (yawDif_Bool || (yawDifReflect_Bool && KP_Params.doReflect) ))
            q = q + 1;
            perspectives(q, :) = pose(:);
        end
    end
    tspan = dt_sample * (q + startDelay_KP + 2)*2;
end

numPerspectives = q;
disp("Number of Perspectives:")
disp(numPerspectives)
clear i q k c x y z theta phi m_Pitch m_Yaw m_YawLine yawLine_KP pose yawDif_Bool yawDifReflect_Bool distance_KP;