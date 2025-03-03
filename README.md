## Opening the Model
1. Install [MATLAB](https://www.mathworks.com/help/install/install-products.html)
2. Using MATLAB, install Simulink
3. After opening Simulink,  select `Project from Git`

## Running the Model
1. load the workspace variables either by double clicking `constants.mat` or running the following command in the matlab terminal.
```matlab
load("constants.mat")
```
> [!WARNING]
> Forgetting to load the variables will cause the model to fail!
2. Run the model using the `Run` command in the toolbar

## Notes About This Model
- All position vectors and matrixes are with respect to the center of mass of the robot. 
  - ex:  `volume-center` is with respect to the center of mass
> [!NOTE] 
> *Message from Zenyn*
> Mathematically, its far more convenint to keep the convention that center-of-mass is origin. Practically, it might become annoying because the center of mass can change. 
> 
> I think the ideal solution is to keep the center of mass orgin, but at some point add a function that would redefine the center of mass relative to a static point (say, thruster 0), and then recalculate all other points, keeping the center of mass at origin.