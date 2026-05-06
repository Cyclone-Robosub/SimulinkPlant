load_system('KP_Collect_UCS');
set_param('KP_Collect_UCS/Simulation 3D Scene Configuration', 'ProjectName', unreal_executable_path);
load_system('CameraCalibration_UCS');
set_param('CameraCalibration_UCS/Simulation 3D Scene Configuration', 'ProjectName', unreal_executable_path);
load_system('SimpleCam_UCS');
set_param('SimpleCam_UCS/Simulation 3D Scene Configuration', 'ProjectName', unreal_executable_path);