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
%sim1=Simulator;
for ct=1:numel(Exp)
    
    Simulator = createSimulator(Exp(ct),Simulator);
    Simulator = sim(Simulator);

    Outputs = cell(size(Simulator.LoggingInfo.Signals));

    for i = 1:length(Simulator.LoggingInfo.Signals)
        Outputs{i}= find(Simulator.LoggedData.logsout{1}.Values,Simulator.LoggingInfo.Signals(i).LoggingInfo.LoggingName);

        Error(:,i) = evalRequirement(r,Outputs{i}.Data,Exp(ct).OutputData(i).Values)';

    end
end
try
    values.F = Error(:);
catch
    warning("assigning values is where it breaks")
end
end