%{
This is the master initialization file for the Cyclone Robosub Simulink.
This is intended to be the one-stop-shop for setting up and running
simulations that are run purely in Matlab and Simulink.

This file can setup, run, plot, and save data from any simulation variant
that includes the _SIM extension in the project. Depending on how the host
machine has been configured, this init may fail for _HIL, _CGN, _EST, and
_UCS models. For these it is recommended to create a custom init for each
case.

If you need to make significant modifications to this file, create a copy
instead and give it an extension such as init_variant and place it in init
archive.

To use this codebase successfully, make sure project_startup.m has been
added to the project settings and ran and that the project is open (i.e.
the Project tab is visible at the top of the screen).
%}

%{
This is the parameter estimation init, cloned off the current main init
file (as of 4/23/26). Similar to the main init, this script will run
similations and other scripts, in particular, those used for parameter
estimation. There are also some key differeneces associated with the
parameter estimation task, such as data preprocessing and the utilization
of the exclusive use of the dynamics_EST model.
%}


%% Housekeeping and Path Management
clc
close all
%clear all %slow, comment this out if you don't need it

%refreshes the file path in case clear all was called
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

%% Set up for Parameter Estimation
%load in data

%{
%save_file = "data/2026_05_02_..."
save_file = "data/2026_05_02_18_22_11";
save_file = fullfile(prj_path_list.user_data_path, save_file);

results = Simulink.SimulationOutput;
results = fileToResults(results,save_file);
%}
moment_type = "L"; %change this depending on the moment you want to focus on

try
    files = dir(fullfile(prj_path_list.user_data_path,moment_type));
    %file = files(end-37);
    %load(fullfile(file.folder,file.name)) %index to chose run (index must be above 2)
    %results = choppedresults(1); %somehow going to have to index this to set up multiple experiemnts...
catch
    run("useful_data_id.m")
    file = files(end-37);
    %load(fullfile(file.folder,file.name))
    %results = choppedresults(1);
end


results = cell(size(files));
for i = 1:length(files)
    file = files(i);
    load(fullfile(file.folder,file.name))
end


%% fiz so that it is itterative
inputStructure.time = results.pwms.Time;
inputSignal1 = double(results.pwms.Data);
inputStructure.signals(1).values = inputSignal1(:,1);
inputStructure.signals(2).values = inputSignal1(:,2);
inputStructure.signals(3).values = inputSignal1(:,3);
inputStructure.signals(4).values = inputSignal1(:,4);
inputStructure.signals(5).values = inputSignal1(:,5);
inputStructure.signals(6).values = inputSignal1(:,6);
inputStructure.signals(7).values = inputSignal1(:,7);
inputStructure.signals(8).values = inputSignal1(:,8);
dt_sim =mean(results.pwms.Time(2:end)-results.pwms.Time(1:(end-1)));

sim_signals = ["ddRb","wb","dRi","qib","Ri"]; %names of the signals in the Dynamics sim
result_signal_names = ["imu_lin_acc", "imu_ang_vel", "dvl_vel","qib","dvl_pos"]; %correlating sensor data
sensorbus_blockpath = "Dynamics_SIM_EST/Subsystem Reference/Dynamics & Kinematics/MATLAB Function";

model_select = "Dynamics_SIM_EST";
open(model_select);
%% Parameters
recalculate_parameters_flag = true; 
if(recalculate_parameters_flag)
    fprintf("Re-calculating vehicle parameters.\n")
    run('buoyancy_calculations.m')
    run('mass_calculations.m')
    run('wrench_calculations.m')
    run("added_mass_calculations.m")
    run("drag_calculations.m")
end

rerun_constants_flag = true;
if(rerun_constants_flag)
    fprintf("Loading saved constants to workspace.\n")
    run('constants.m') %load all necessary constants into the workspace
end

%% Initial Conditions
fprintf("Defining initial conditions.\n")
%initial intertial position
% xi_0 = 0; yi_0 = 0; zi_0 = 0;
xi_0 = squeeze(results.Ri.Data(1,1,1));yi_0 = squeeze(results.Ri.Data(2,1,1)); zi_0 = squeeze(results.Ri.Data(3,1,1));
Ri_0 = [xi_0; yi_0; zi_0];

%initial intertial velocity
%ui_0 = 0; vi_0 = 0; wi_0 = 0;
ui_0 = results.dvl_vel.Data(1,1,1); vi_0 = results.dvl_vel.Data(2,1,1); wi_0 = results.dvl_vel.Data(3,1,1);
dRi_0 = [ui_0; vi_0; wi_0];

%initial euler angles
%phi_0 = 0; theta_0 = 0; psi_0 = 0;
phi_0 = results.Eul.Data(1,1,1); theta_0 = results.Eul.Data(2,1,1); psi_0 = results.Eul.Data(3,1,1);
Eul_0 = [phi_0; theta_0; psi_0]; %[roll, pitch, yaw]

%other attitude representations
Cib_0 = eulToRotm(Eul_0);
q_0 = eulToQuat(Eul_0); %[vector; scalar]

%initial angular velocity
%wbx_0 = 0; wby_0 = 0; wbz_0 = 0;
wbx_0 = results.wb.Data(1,1,1); wby_0 = results.wb.Data(2,1,1); wbz_0 = results.wb.Data(3,1,1);
wb_0 = [wbx_0; wby_0; wbz_0];

%pack initial state
X0 = [Ri_0;q_0;dRi_0;wb_0];

%initial conditions for the state estimator
q0_ekf = [0 0 0 1]';
q0_est = [0 0 0 1]';
P0_ekf = 0.1*eye(6); 
B0_ekf = zeros(3,1);

%% Test Conditions
% Not all test conditions are needed for every model
fprintf("Defining test case.\n")

%battery voltage
const_voltage = 15;

%Simple_Joystick_SIM
const_joy = [0 0 0 0 0 0]'; %[Y, X ,Rise,Sink,Yaw,Pitch]
FT_list_test = 10*[0 0 0 0 10 -10 10 -10]';
test_pwm_list = [1500 1500 1500 1500 1500 1500 1500 1500]';

%flags are used to turn parts of the simulation on and off
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; 
do_torque_flag = 1; 
do_force_flag = 1; 
use_true_state_flag = 0;

%measured imu misalignment
Cbimu_meas = [1 0 0;...
    0 0 1;...
    0 -1 0];

%% Simulation Parameters
fprintf("Setting simulation config.\n")

%simulation duration

%tspan = 30;
tspan = 999999;

%timesteps for various simulation components
%dt_sim = 1/1000; %sim timestep
dt_data = roundToSimTimestep(1/30, dt_sim); %data saving timestep
dt_control = roundToSimTimestep(1/100, dt_sim); %controller timestep
dt_dvl = roundToSimTimestep(1/5, dt_sim);
dt_imu = roundToSimTimestep(1/100, dt_sim);
dt_dvl_vr = roundToSimTimestep(1/20, dt_sim);
%mission file and model
%mission_file_name = "drive_in_square_validation_mission.txt"; 
%model_select = "FB_Controller_SIM";
%open_system(model_select);


%setup for bus objects (necessary to use structures in Simulink)
max_commands_in_mission = 64; 
setup_buses_flag = true;
if(setup_buses_flag)
    fprintf("Setting up busses.\n")
    run('setup_cmd_bus.m');
    run('setup_FF_maneuvers_bus.m');
    run('setup_state_bus.m');
    run('setup_sensor_bus.m');
    run('setup_RSFF_maneuvers_bus.m')
end


%set To-File block names
%to_file_block_path = setToFileBlockNames(model_select, prj_path_list.user_data_path);
%enableToFileBlocks(model_select);
%disableToFileBlocks(model_select);

%comment or uncomment the to-workspace blocks (for performance reasons)
%enableToWorkspaceBlocks(model_select);
%disableToWorkspaceBlocks(model_select);

%% Post Processing
fprintf("Running Post-Processing.\n")
run('setup_plots_EST.m')

% Add any the outputs of ToFile blocks to the results structure
%results = fileToResults(results, to_file_block_path);

% Enter the names of all the plots as a comma separated cell array
% Refer to setup_plots.m to see the valid plot names
plot_names = {"X","pwm_cmd"};
plotAllOutputs(plots,results,plot_names);

% saveStateGif(results.Ri.Time,squeeze(results.Ri.Data),results.q.Data,prj_path_list.temp_path,"test");

% saveOutputMat(results,prj_path_list.user_data_path,do_state_save_flag,do_gif_flag);

fprintf("Done.\n\n")

%% Parameter Estimation
%{
fprintf("Running Parameter Estimation.")
params_to_estimate = ["drag"];
run("param_estimator.m")
%}