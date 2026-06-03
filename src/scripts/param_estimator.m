%% param_estimator
%   Script where parameter estimation is run.

% experimental data includes dw,ddw,ddRi,dRi

%need to update for using plant instead of FB_Controller_SIM
    %update output signal information
    %add FT information as inputt signals.


%% inertia estimation
if sum(contains(params_to_estimate, "inertia")) >= 1
    %set up
    subsystem_blockpath = "Subsystem Reference (plant)";
    inertia_EST_info = param_sim_location(results, {'I','invM', 'invI'}, model_select, subsystem_blockpath, sim_signals, result_signal_names, sensorbus_blockpath, [0,0,0,0,0], [5,4,3,2,1]);
    [Exp_I,Sim_I] = inertia_EST_info.createExperimentAndSimulator();
    max_I = {[3,0,3;0,3,0;3,0,3], diag([1,1,1]), [6,0,6;0,6,0;6,0,6]};
    min_I = {[0,0,0;0,0,0;0,0,0],diag([-1,-1,-1]), [-1,0,-1;0,-1,0;-1,0,-1]};

    v = getParameters(inertia_EST_info,max_I,min_I, Exp_I);

    %estimation objective
    estFcn = @(v) sp_objective(v,Sim_I,Exp_I);

    %estimation method
    opt = sdo.OptimizeOptions;
    opt.Method = 'lsqnonlin'; %least sqaures non linear method
    sim_save = sim(Sim_I);
    plotAllOutputs(plots,sim_save.LoggedData,plot_names)

    %estimate the parameters
    vOpt = sdo.optimize(estFcn,v,opt)
    
    I = vOpt(1).Value; invM = vOpt(2).Value; inv_ = vOpt(3).Value;
    sim_save = sim(Sim_I);
    sim_save.LoggedData.pwms = results.pwms;
    plotAllOutputs(plots,sim_save.LoggedData,plot_names)
end

%% drag estimation
if sum(contains(params_to_estimate, "drag")) >=1
    %set up
    subsystem_blockpath = "Subsystem Reference (plant)";
    drag_EST_info = param_sim_location(results,{'drag_wrench'}, model_select, subsystem_blockpath, sim_signals,result_signal_names, sensorbus_blockpath, [0,0,0,0,0], [5,4,3,2,1]);
    [Exp_drag,Sim_drag] = drag_EST_info.createExperimentAndSimulator();
    max_drag = {[100.*eye(3), zeros(3); zeros(3), 100.*eye(3)]};
    min_drag = {[0.1.*eye(3), zeros(3); zeros(3), 0.1.*eye(3)]};

    v = getParameters(drag_EST_info,max_drag,min_drag, Exp_drag);

    %estimation objective
    estFcn = @(v) sp_objective(v,Sim_drag,Exp_drag);

    %estimation method
    opt = sdo.OptimizeOptions;
    opt.Method = 'lsqnonlin'; %least sqaures non linear method
    sim_save = sim(Sim_drag);
    plotAllOutputs(plots,sim_save.LoggedData,plot_names)

    %estimate the parameters
    vOpt = sdo.optimize(estFcn,v,opt)
    
    drag_wrench = vOpt(1).Value;
    sim_save = sim(Sim_drag);
    sim_save.LoggedData.pwms = results.pwms;
    plotAllOutputs(plots,sim_save.LoggedData,plot_names)
end

%% mass estimation
if sum(contains(params_to_estimate, "mass"))>=1
    subsystem_blockpath = "Dynamics_SIM/Subsystem Reference (plant)";
    mass_EST_info = param_sim_location(results, {'m'}, model_select, subsystem_blockpath, sim_signals, result_signal_names, sensorbus_blockpath, [0,0,0,0,0], [5,4,3,2,1]);

    [Exp_mass,Sim_mass] = mass_EST_info.createExperimentAndSimulator();
    max_mass = {[30]}; %[kg]
    min_mass = {[10]}; %[kg]
    v = getParameters(mass_EST_info,max_mass,min_mass, Exp_mass);
    %estimation objective
    estFcn = @(v) sp_objective(v,Sim_mass,Exp_mass);

    opt = sdo.OptimizeOptions;
    opt.Method = 'lsqnonlin'; %least sqaures non linear method
    sim_save = sim(Sim_mass);
    plot_names = {"X","pwm_cmd"};
    sim_save_results = sim_save.LoggedData;
    sim_save_results.pwms = timeseries( ...
        [sim_save.Inputs(1).Values.Data,sim_save.Inputs(2).Values.Data,...
        sim_save.Inputs(3).Values.Data,sim_save.Inputs(4).Values.Data,...
        sim_save.Inputs(5).Values.Data,sim_save.Inputs(6).Values.Data,...
        sim_save.Inputs(7).Values.Data,sim_save.Inputs(8).Values.Data],...
        sim_save.Inputs(1).Values.Time, 'Name', 'pwms');
    %sim_save_results.pwms.Name = 'pwms';
    plotAllOutputs(plots,sim_save_results,plot_names)

    %estimate the mass
   %{
    vOpt = sdo.optimize(estFcn,v,opt)
    
    m = vOpt(1).Value
    Sim_mass = createSimulator(Exp);
    sim_save = sim(Sim_mass);
    plotAllOutputs(plots,sim_save.LoggedData,plot_names)
    %}
end




