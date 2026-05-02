function values = sp_objective(v, Simulator, Exp)
%MSD_OBJECTIVE 
%   This function compares the simulated data to the experimental data. It
%   is utilized in parameter estimation to preform regressoin.
%       v = array that contains parameter information and the initial states and parameters
%       Simulator = simulator that gets run based on the sim.
%       Exp = Experiment set up from collected data.
%       param_sim_location = class param_sim_location that orgnaizes information about the signals and systems related to a parameter.

%signal tracking requirement
r = sdo.requirements.SignalTracking;
r.Type = '==';
r.Method = 'Residuals';
r.Normalize =  'off';

%update experiment with estimated parameter values;
Exp = setEstimatedValues(Exp,v);

%running simulator to comapare with experimental data.
Error = [];
sim1=Simulator;
for ct=1:numel(Exp)
    
    Simulator = createSimulator(Exp(ct),Simulator);
    Simulator = sim(Simulator);

    %SimLog  = find(Simulator.LoggedData,get_param(Simulator.Name,'SignalLoggingName'));
    try
        SimLog = find(Simulator.LoggedData, 'logsout');
    catch
        warning("the first find statment breaks it")
    end
    disp(SimLog{3})
    Outputs = cell(size(sim1.LoggingInfo.Signals));
    for i = 1:length(sim1.LoggingInfo.Signals)
        try
            Outputs{i} = find(Simulator.LoggedData,...
                sim1.LoggingInfo.Signals(i).LoggingInfo.LoggingName);
        catch
            warning("the second find statment breaks it")
        end
        disp(Outputs{i}.Values)
        disp(evalRequirement(r,Outputs{i}.Values,Exp(ct).OutputData(i).Values)');
        try
            Error(:,i) = evalRequirement(r,Outputs{i}.Values,Exp(ct).OutputData(i).Values)';
        catch
            disp("the evalRequirement is where it breaks");
        end
    end
end
try
    values.F = Error(:);
catch
    warning("assigning values is where it breaks")
end
end