%{
This is the master initialization file for the Cyclone Robosub Simulink.

This file can setup, run, plot, and save data from any simulation variant
included in the system. 

If you need to make significant modifications to this file, create a copy
instead and give it an extension such as init_variant and place it in init
archive.
%}

%% Housekeeping and Path Management
clc
close all

if(~exist('prj_path_list','var'))
    prj_path_list = getProjectPaths();
end

stashASVFiles(); %move pesky .asv files out of the way

%% Parameters
run('constants.m')

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
q_0 = rotm2quat(Cib_0); 

%reorder because the scalar should be at the end for calcs in the sim
q_0 = [q_0(2); q_0(3); q_0(4); q_0(1)];

%initial angular velocity
wx_0 = 0;
wy_0 = 0;
wz_0 = 0;
wb_0 = [wx_0; wy_0; wz_0];

%pack initial state
X0 = [Ri_0;q_0;dRi_0;wb_0];

%% Test Conditions
%list of thruster forces
test_ft_list = zeros(8,1); %used by Dynamics

%% Simulation Parameters

%simulation duration
tspan = 60;

%simulation time step
dt_sim = 0.0001;

%data saving rate
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim

%controller update rate
dt_control = 0.01;

%flags are used to turn parts of the simulation on and off
do_buoyancy_flag = 1;
do_gravity_flag = 1;
do_drag_flag = 1;
do_thrusters_flag = 1;
do_time_flag = 1; 
do_torque_flag = 1; 
do_force_flag = 1; 
do_Fb_correction = 0; 
overwrite_mission_file_wp_flag = 1;
overwrite_mission_file_mode_flag = 1;

%mission file
mission_file_path = fullfile(prj_path_list.inits_path,"mission_file.txt");
mission_file = importMissionCSV(mission_file_path);

%control mode (valid options MODE_NONE - no control, 1 MODE FF - feedforward, 2, MODE_PID - feedback PID control)
mode_overwrite = 2;

%target state (only used if overwrite_mission_file_wp_flag = 1)
R_target = [10; 0; 0;];
Eul_target = [0; 0; 0];
state_overwrite = [R_target;Eul_target];

%tolerances
roll_error_tol = 5*pi/180;
pitch_error_tol = 5*pi/180;
yaw_error_tol = 5*pi/180;
w_tol = 0.1;
%% Simulation
name = "Feedforward_Control";

%specify all variables that will be logged w/ to-workspace
%if no plots are provided, EVERYTHING will be plotted
plots = {'Ri','Eul'};

%disable unneeded to-workspace blocks for performance
%TODO move this to a simulation startup script if possible

%find all the to-workspace blocks
to_workspace_blocks = find_system(name,'BlockType','ToWorkspace');

%if the user chose some variable names to plot
if exist('plots','var') && ~isempty(plots)
    %loop over all the to-workspace blocks
    for k = 1:numel(to_workspace_blocks)

        %disable the blocks that are not included in plots
        var_name = get_param(to_workspace_blocks{k},VariableName');
        if ~ismember(var_name, plots)
            set_param(to_workspace_blocks{k},'SaveOutput','off');
        end
    end
end


%you can change the simulation input name and mission_file name.
simIn = Simulink.SimulationInput(name);
simIn = simIn.setVariable('mission_file',mission_file);
results = sim(simIn);

%% Post Processing
plotAllOutputs(results,plots);
