clc
close all
clear all

%{
This init generates data for a rotation in a gravity-less vaccum with
initial angular velocity in the roll, pitch, and yaw directions.
%}
%% Run setup scripts
run('constants_dyn.m')

%% Set Sim Parameters
reltol = 1e-9;
abstol = 1e-9;

tspan = 10;
dt_data = 1/30;
dt_control = 0.01;
%% Initial Conditions
%initial intertial position
xi_0 = 0;
yi_0 = 0;
zi_0 = 0;
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
ui_0 = 0;
vi_0 = 0;
wi_0 = 0;
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
phi_0 = 0;
theta_0 = 0;
psi_0 = 0;
Eul_0 = [phi_0; theta_0; psi_0];

%other attitude representations
Cib_0 = eul2rotm([psi_0,theta_0,phi_0],'ZYX');
qib_0 = rotm2quat(Cib_0); 

%reorder because the scalar should be at the end for calcs in the sim
qib_0 = [qib_0(2); qib_0(3); qib_0(4); qib_0(1)];






%flags
do_buoyancy_flag = 0;
do_gravity_flag = 0;
do_drag_flag = 0;

%% Run Sim
%create the simIn object to pass in model parameters
ft_list = [0 0 0 0 0 0 0 0];

%initial angular velocity
wx_0 = [0.2 0 0];
wy_0 = [0 0.2 0];
wz_0 = [0 0 0.2];
wb_0 = [wx_0; wy_0; wz_0];

for k = 1:3
    wb_0 = [wx_0(k),wy_0(k),wz_0(k)]';
    %pack initial state
    X0 = [Ri_0;qib_0;dRi_0;wb_0];
    simIn = Simulink.SimulationInput("Dynamics");
    simIn = simIn.setVariable('ft_list_test',ft_list);
    results = sim(simIn);
    
    gif_data = {results.Ri,results.Eul,ft_list};
    
        
    %% Run Post Processing
    %plotAllOutputs(results);
    path = 'C:\GitHub\Cyclone Robosub\SimulinkPlant\src\temp';
    saveAllOutputs(results,path);

end
    

