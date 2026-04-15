%{
This file contains all simulation parameters that refer to the state of the
vehicle that does not change during a simulation or do not refer to initial
conditions. 

constants.m without any modifiers is meant to be kept up to date. 
Constant files named constants_[modifier].m are used for specific test
cases that don't reflect the values used for the vehicle normally.
%}

% call getProjectPaths if it doesn't exist
if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

%Camera Calibration variable loading.

cam_Cal_Distance = 130;

try
    %{
    Assigns distortion coefficients to array of size 5 [k1 k2 p1 p2 k3] from
    stereoParams. 
    Assigns intrinsic matrices (K_L and K_R)
    %}
    stereoCam = coder.load(fullfile(prj_path_list.UCS_lookup_path,"stereoParams4_11.mat"));
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
catch
    error("Unable to load stereo parameters")
end