## Task List
### PID 
- [x] Replace Manual PID parameters with tuning blocks
- [x] Change `constants.mat` to constants `constants.m`
- [ ] Tune PID to improve sim reslts
### Plant
- [ ] Break up `drag_wrench` into rows for experiments
- [ ] Break up mass constants in model for easy tuning 
- [ ] Check mass and volume
- [ ] Find volume center
### IMU
- [x] accepts six axis body frame acceleration as input (one, six-axis input signal)
- [x] adds Gaussian white noise
- [x] sends six axis body frame acceleration w/ noise as output (one, six-axis output signal)
- [ ] find noise of actual imu (does it match the model)
### SPU
- [x] accepts six axis body frame acceleration w/ noise as input (one, six-axis input signal)
- [ ] applies low pass digital filter to remove noise
- [x] integrates and applies rotation matrix to find body frame and world frame acceleration, velocity, position
- [x] outputs six axis acceleration, velocity, and position in world frame and body frame (six, six-axis output signals)
### Pathfinding
- [ ] understand pathfinding
- [ ] Implement pathfinding 


## Opening the Model
1. Install [MATLAB](https://www.mathworks.com/help/install/install-products.html)
2. Using MATLAB, install Simulink
3. After opening Simulink,  select `From Source Control` and then `Git`
![setup](docs/setup.png)
4. After setting up Git, the project panel should open. From here you can begin work!

## Running and Maintaining the Model
**Always use the MATLAB Project source control.** MATLAB has developed this tool to prevent sharing of temporary files and other unwanted information. A project also has associated start-up files, so starting without first running the project will cause the Simulink model to fail. 

![project page](docs/project.png)

> [!WARNING]
> If you add additional files to the directory that you want source controlled, you need to manually add them to the project by right-clicking on the file and going `Add to Project` 
> ![add to project](docs/add-to-project.png)


## Notes About This Model
- All position vectors and matrixes are with respect to the center of mass of the robot. 
  - ex:  `volume-center` is with respect to the center of mass
> [!NOTE] 
> **Message from Zenyn**
>
> Mathematically, its far more convenint to keep the convention that center-of-mass is origin. Practically, it might become annoying because the center of mass can change. 
> 
> I think the ideal solution is to keep the center of mass orgin, but at some point add a function that would redefine the center of mass relative to a static point (say, thruster 0), and then recalculate all other points, keeping the center of mass at origin.

## Resources
- [Project Information Page](https://www.mathworks.com/help/releases/R2024b/simulink/ug/try-simulink-project-tools-with-the-airframe-project.html)
- [Creating a System in Simulink](https://www.mathworks.com/help/releases/R2024b/simulink/gs/system-definition-and-layout.html) (Part 1 of 3)
- [Model-Based Design](https://www.mathworks.com/help/releases/R2024b/simulink/gs/model-based-design.html)
- [Best Practices](https://www.mathworks.com/company/technical-articles/best-practices-for-implementing-modeling-guidelines-in-simulink.html)