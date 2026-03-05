clear all; clc; close all; %cleared here to reset any user changes before validation
%{
This scripts runs an FT_cmd_list and compares the command list to force
delivered to the plant.

The model validate_thruster_conversions.slx has been configured to accept
external inputs.
(In model) Modeling > Model Settings > Data Import/Export
Check Input
Set field to inputData
%}

%get the paths
if(~exist('prj_path_list','var')) 
    prj_path_list = getProjectPaths();
end

%Sim setup
dt_sim = 0.001; %(s)
tspan = 10;
%data saving rate
dt_data_target = 1/30;
dt_data = round((dt_data_target/dt_sim))*dt_sim; %make sure dt_data is a multiple of dt_sim
%controller update rate
dt_control_target = 0.01;
dt_control = round((dt_control_target/dt_sim))*dt_sim; %make sure dt_control is a multiple of dt_sim


%Inputs
N = 1000; %number of samples
FT_min = -100; %FT_cmd upper and lower bound (N)
FT_max = 100; 
const_voltage = 14;
FT_cmd_list = ones(8,1)*linspace(FT_min, FT_max, N);
FT_cmd_list = FT_cmd_list';
t = linspace(0,tspan*(1 - 1/N),N);

%Package for Simulink
FT_cmd_list_ts = timeseries(FT_cmd_list, t);
voltage_ts = timeseries(const_voltage*ones(size(t)),t);
inputData = Simulink.SimulationData.Dataset;
inputData = inputData.addElement(FT_cmd_list_ts, 'FT_cmd_list');
inputData = inputData.addElement(voltage_ts,'voltage');

%Run the script that defines the necessary constants
run('constants.m')

%Set up and run sim
simIn = Simulink.SimulationInput('validate_thruster_conversions_sim');
simIn = simIn.setExternalInput(inputData);
results = sim(simIn);

FT_list = results.get('FT_list');

figure()
for k = 1:8
    subplot(4,2,k)
    plot(FT_list.Time,FT_list.Data(:,k))
    hold on
    plot(FT_cmd_list_ts.Time,FT_cmd_list_ts.Data(:,k))
    title(sprintf("Thruster %i",k))
    xlabel("Time (s)")
    ylabel("Force (N)")
    legend("Delivered", "Commanded")
end



