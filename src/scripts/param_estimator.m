%% param_estimator
%   Script where parameter estimation is run.

% bro, I have no idea what matricies are like for parameter estimation...
% bro, we probably are only able to stimate from the experimental data
% experimental data includes dw,ddw,ddRi,dRi

open(model_select);

sim_signals = ["linAccel", "Gyro", "Mag", "dRb", "alt_meas_dvl", "dRb_conv_dvl", "eul_dvl","Rb_dvl"];
sim_result_signal_names = ["imu_lin_acc", "imu_ang_vel","imu_mag", "dvl_vel", "dvl_alt","dvl_cov","dvl_eul","dvl_pos"];
sensorbus_blockpath = "FB_Controller_SIM/Sensor Model/sensorModelToSensorBus";
%% inertia estimation
if sum(contains(params_to_estimate, "inertia")) >= 1
    %set up
    subsystem_blockpath = "FB_Controller_SIM/Physics Model/Dynamics & Kinematics";
    inertia_EST_info = param_sim_location(results, {'I','invM', 'invI'}, model_select, subsystem_blockpath, sim_signals, sim_result_signal_names, sensorbus_blockpath, [0,0,0,0,0,0,0,0], [1,2,3,4,5,6,7,8]);
    [Exp_I,Sim_I] = inertia_EST_info.createExperimentAndSimulator();
    max_I = {[3,3,3;3,3,3;3,3,3]};
    min_I = {[1,1,1;1,1,1;1,1,1]};
    v = getParameters(inertia_EST_info,max_I,min_I, Exp_I);

    %estimation objective
    estFcn = @(v) sp_objective(v,Sim_I);

    %estimation method
    opt = sdo.OptimizeOptions;
    opt.Method = 'lsqnonlin'; %least sqaures non linear method

    %estimate the parameters
    try
        vOpt = sdo.optimize(estFcn,v,opt);
    catch
        warning("Inertia estimation has failed")
    end

end

%% drag estimation
if sum(contains(params_to_estimate, "drag")) >=1
    %set up
    subsystem_blockpath = "FB_Controller_SIM/Physics Model/Hydrodynamics";
    drag_EST_info = param_sim_location(results,{'drag_wrench'}, model_select, subsystem_blockpath, sim_signals,sim_result_signal_names, sensorbus_blockpath, [0,0,0,0,0,0,0,0], [1,2,3,4,5,6,7,8]);
    [Exp_drag,Sim_drag] = drag_EST_info.createExperimentAndSimulator();
    max_drag = [100.*diag(1,1,1), zeros(3); zeros(3), 100.*diag(1,1,1)];
    min_drag = [0.1.*diag(1,1,1), zero(3); zeros(3), 0.1.*diag(1,1,1)];
    v = getParameters(drag_EST_info,max_drag,min_drag, Exp_drag);
    %estimation objective
    estFcn = @(v) sp_objective(v,Sim_drag);

    %estimation method
    opt = sdo.OptimizeOptions;
    opt.Method = 'lsqnonlin'; %least sqaures non linear method

    %estimate the parameters
    try
        vOpt = sdo.optimize(estFcn,v,opt);
    catch
        warning("estimation of drag failed")
    end
end

%% mass estimation
if sum(contains(params_to_estimate, "mass"))>=1
    subsystem_blockpath = "FB_Controller_SIM/Physics Model/Gravity";
    %mass_EST_info = param_sim_location(results, {'m'}, model_select, subsystem_blockpath, sim_signals, sim_result_signal_names, sensorbus_blockpath, [0,0,0,0,0,0,0,0], [1,2,3,4,5,6,7,8]);
        mass_EST_info = param_sim_location(results, {'m'}, model_select, subsystem_blockpath, sim_signals(1:2), sim_result_signal_names(1:2), sensorbus_blockpath, [0,2], [1,2]);

    [Exp_mass,Sim_mass] = mass_EST_info.createExperimentAndSimulator();
    Sim_mass = sim(Sim_mass);
    max_mass = {[30]}; %[kg]
    min_mass = {[10]}; %[kg]
    v = getParameters(mass_EST_info,max_mass,min_mass, Exp_mass);
    %estimation objective
    estFcn = @(v) sp_objective(v,Sim_mass,Exp_mass);

    opt = sdo.OptimizeOptions;
    opt.Method = 'lsqnonlin'; %least sqaures non linear method

    %estimate the mass
    %try
        %vOpt = sdo.optimize(estFcn,v,opt)
    %catch
        %warning("estimation of mass has failed")
    %end
end




