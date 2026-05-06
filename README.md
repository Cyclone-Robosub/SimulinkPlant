# Unreal Co-Sim (UCS) Branch
This branch is for integrating Unreal executables and vision with controls architecture. So far, this branch contains UCS camera calibration, keypoint (KP) training data collection, and basic UCS initiliaziation functions and constants. If you are unfamiliar with how SimulinkPlant is organized or how to setup, refer to Controls documentation on notion.

---

## Unreal Executable upload instructions
The Unreal executable is located in the vision google drive for Cyclone robosubs. If you do not have access to the google drive, send a message in the vision channel and someone will add you. The folder Unreal Executable will have .zip files that will say either Windows or Linux. Pick the one corresponding to your OS and extract all files from it. When running SimulinkPlant, look at the messages in startup for more instructions.

Note: When uploading the exe to SimulinkPlant drag and drop ALL of the files from the windows or linux folder to the drop folder. DONT just drag the exe.

---

# Init Functions

---

## KP Training Data
Run initKPCollect_UCS in matlab command window. This will collect images with keypoints labeled. In the SavedImages/CalibrationImages folder. The images will generated with default parameters unless specified otherwise. The collection algorithm generates images in a lattice of mostly evenly spaced, somewhat random perspectives. To adjust the parameters set the values in the KP_Params struct.

For Example:
```bash
KP_Params.distance = 500
```
will set the distance of the camera 500 cm away from the prop.

Ignore all exact____ KP_Params as these were for debugging. 

Here is a list of all of the parameters and their default values, they are pretty self explanatory. They limit the range of the generated perspectives of the camera's viewing distance, roll, pitch, and yaw. In addition there are "Noise" parameters to add some randomness and also adjust the camera view so the camera isn't looking directly at the center of the prop. 

Range Parameters
KP_Params.pitchMin = - pi / 4;
KP_Params.pitchMax = pi / 4;
KP_Params.yaw = 0;
KP_Params.yawRadius = pi / 3;
KP_Params.distance = 400;
KP_Params.doReflect = false;
KP_Params.N = 400;         % Amount of points in fibonacci lattice

Noise Parameters
KP_Params.rollNoise = pi;
KP_Params.pitchNoise = pi / 90;
KP_Params.yawNoise = pi / 60;
KP_Params.distanceNoise = 20;
KP_Params.xNoise = 0;
KP_Params.yNoise = 0;
KP_Params.zNoise = 0;

Prop Choice
KP_Params.propChoice = "Gate";

Background Parameters
KP_Params.backgroundValue = 0;
KP_Params.backgroundCycle = false;

For the backgroundValue, I would suggest either leaving it as 0, or setting backgroundCycle to true, so that it cycles through a preset list of textured backgrounds. I will be adding more backgrounds in the future.

TODO: 
1. Currently I only have the "Gate" prop added to this executable. This will change soon.