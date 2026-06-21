%{
    Default constants for _UCS models.
%}

% call getProjectPaths if it doesn't exist
if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

%World Values
ground_Z = 100;
waterLevel_Z = -180;

%Grid Square Size
squareSize = 5; %Measured in cm. There are 10x7 of them

%Camera Calibration variable loading.
cam_Cal_Distance = 130;
rel_CamPose_L = [40 -2.5 -15 0 0 0];
rel_CamPose_R = [40 2.5 -15 0 0 0];
M_WorldToUCS = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 -1 0 0 0; 0 0 0 (180 / pi) 0 0; 0 0 0 0 (180 / pi) 0; 0 0 0 0 0 (180 / pi)];
M_UCSToWorld = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 -1 0 0 0; 0 0 0 (pi / 180) 0 0; 0 0 0 0 (pi / 180) 0; 0 0 0 0 0 (pi / 180)];
rel_CamPose_L_UCS = rel_CamPose_L*M_WorldToUCS;
rel_CamPose_R_UCS = rel_CamPose_R*M_WorldToUCS;

%% Simulation Parameters
%simulation duration
tspan = 5;

%Delay (in units of dt_sample) of how long to wait for lighting to calibrate
startDelay_KP = 34; %Needs to be multiples of 2.

%timesteps for various simulation components
dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/30, dt_sim); %data saving timestep
dt_sample = 0.03;


%% Camera Parameters

%try
    %{
    Assigns distortion coefficients to array of size 5 [k1 k2 p1 p2 k3] from
    stereoParams. 
    Assigns intrinsic matrices (K_L and K_R)
    %}


    stereoCam = coder.load(fullfile(prj_path_list.UCS_lookup_path,"stereoParams.mat"));
    
    stereoParams = stereoCam.stereoParams;
    clear CameraParameters1 CameraParameters2 RectificationParams stereoStruct Version;
    
    stereoStruct = toStruct(stereoParams);
    
    stereo_WorldUnits = stereoStruct.CameraParameters1.WorldUnits;
    stereo_Version_Name = stereoStruct.Version.Name;
    stereo_Version_Version = stereoStruct.Version.Version;
    stereo_Version_Release = stereoStruct.Version.Release;
    stereo_Version_Date = stereoStruct.Version.Date;
    stereo_OutputView = stereoStruct.RectificationParams.OutputView;

    stereoStruct.CameraParameters1.Version = 1.0;
    stereoStruct.CameraParameters2.Version = 1.0;
    stereoStruct.CameraParameters1 = rmfield(stereoStruct.CameraParameters1,"WorldUnits");
    stereoStruct.CameraParameters2 = rmfield(stereoStruct.CameraParameters2,"WorldUnits");
    stereoStruct.RectificationParams = rmfield(stereoStruct.RectificationParams,"OutputView");
    stereoStruct = rmfield(stereoStruct,"Version");

    stereoBusInfo = Simulink.Bus.createObject(stereoStruct);

    stereo_bus = slBus1;
    
    stereo_params = Simulink.Parameter(stereoStruct);
    stereo_params.DataType = 'Bus: stereo_bus';

    clear slBus1;
    

    %{
    clear CameraParameters1 CameraParameters2 RectificationParams stereoStruct;
    
    s = toStruct(stereoParams);
    
    stereoStruct.CameraParameters1.RadialDistortion = s.CameraParameters1.RadialDistortion;
    stereoStruct.CameraParameters1.TangentialDistortion = s.CameraParameters1.TangentialDistortion;
    stereoStruct.CameraParameters1.ImageSize = s.CameraParameters1.ImageSize;
    stereoStruct.CameraParameters1.NumRadialDistortionCoefficients = s.CameraParameters1.NumRadialDistortionCoefficients;
    stereoStruct.CameraParameters1.K = s.CameraParameters1.K;
    stereoStruct.CameraParameters2.RadialDistortion = s.CameraParameters2.RadialDistortion;
    stereoStruct.CameraParameters2.TangentialDistortion = s.CameraParameters2.TangentialDistortion;
    stereoStruct.CameraParameters2.ImageSize = s.CameraParameters2.ImageSize;
    stereoStruct.CameraParameters2.NumRadialDistortionCoefficients = s.CameraParameters2.NumRadialDistortionCoefficients;
    stereoStruct.CameraParameters2.K = s.CameraParameters2.K;
    stereoStruct.RotationOfCamera2 = s.RotationOfCamera2;
    stereoStruct.TranslationOfCamera2 = s.TranslationOfCamera2;
    stereoStruct.RectificationParams = s.RectificationParams;
    stereoStruct.RectificationParams = rmfield(stereoStruct.RectificationParams,"OutputView");
    clear s;

    stereoBusInfo = Simulink.Bus.createObject(stereoStruct);
    
    stereo_bus = slBus1;
    
    clear slBus1;
    
    %}
    

    k_L = stereoCam.stereoParams.CameraParameters1.K;
    k_R = stereoCam.stereoParams.CameraParameters2.K;

    distort_coefL = zeros(1, 5);
    if stereoCam.stereoParams.CameraParameters1.NumRadialDistortionCoefficients >= 1
        distort_coefL(1) = stereoCam.stereoParams.CameraParameters1.RadialDistortion(1);
    end
    if stereoCam.stereoParams.CameraParameters1.NumRadialDistortionCoefficients >= 2
        distort_coefL(2) = stereoCam.stereoParams.CameraParameters1.RadialDistortion(2);
    end
    if stereoCam.stereoParams.CameraParameters1.NumRadialDistortionCoefficients >= 3
        distort_coefL(5) = stereoCam.stereoParams.CameraParameters1.RadialDistortion(3);
    end
    distort_coefL(3) = stereoCam.stereoParams.CameraParameters1.TangentialDistortion(1);
    distort_coefL(4) = stereoCam.stereoParams.CameraParameters1.TangentialDistortion(2);
    
    distort_coefR = zeros(1, 5);
    if stereoCam.stereoParams.CameraParameters2.NumRadialDistortionCoefficients >= 1
        distort_coefR(1) = stereoCam.stereoParams.CameraParameters2.RadialDistortion(1);
    end
    if stereoCam.stereoParams.CameraParameters2.NumRadialDistortionCoefficients >= 2
        distort_coefR(2) = stereoCam.stereoParams.CameraParameters2.RadialDistortion(2);
    end
    if stereoCam.stereoParams.CameraParameters2.NumRadialDistortionCoefficients >= 3
        distort_coefR(5) = stereoCam.stereoParams.CameraParameters2.RadialDistortion(3);
    end
    distort_coefR(3) = stereoCam.stereoParams.CameraParameters2.TangentialDistortion(1);
    distort_coefR(4) = stereoCam.stereoParams.CameraParameters2.TangentialDistortion(2);
%catch
    %error("Unable to load stereo parameters")
%end
