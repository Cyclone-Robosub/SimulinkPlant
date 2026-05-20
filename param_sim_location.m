classdef param_sim_location
    %PARAM_FROM_SIM Summary of this class goes here
    %   Class to orgnaize the information relating different paramters to
    %   the signals which we estimate them from.

    properties
        params = {};
        model = "";
        signals = [Simulink.SimulationData.Signal];
        blockpath = "";
        input
    end

    methods
        function obj = param_sim_location(results, params, model, blockpath, signal_names, signal_data_names, signal_paths, outin, ports)
            %PARAM_FROM_SIM Construct an instance of this class
            %   Detailed explanation goes here
            obj.params = params;
            obj.model = model;
            obj.blockpath = blockpath;
            for i = 1:length(signal_names)
                obj.signals(i) = Simulink.SimulationData.Signal;
                obj.signals(i).Name = signal_names(i);
                if isStringScalar(signal_paths)
                    obj.signals(i).BlockPath = signal_paths; % signal block path should be here
                else
                    obj.signals(i).BlockPath = signal_paths(i);
                end
                if logical(outin(i)) % an outin(i) of 1 assigns the signal as an output
                    obj.signals(i).PortType = "outport";
                else
                    obj.signals(i).PortType = "inport";
                end
                obj.signals(i).PortIndex = ports(i);

                obj.signals(i).Values = results.(signal_data_names(i));
                %obj.signals(i).Values = obj.signals(i).Values.Data;
                obj.signals(i).Values.Name = signal_names(i);
            end
            %obj.input = double(results.pwms.Data); %might have to be changed depending of data
        end

        function [Exp,Sim] = createExperimentAndSimulator(obj)
            %createExperiment creates expeiment from a param_sim_location
            %   param_simloc contains information for the parameters to be
            %   estimated as well as what signals they are estimated from.
            %   This method then uses that information to make an sdo
            %   Experiment that will be used for parameter estimation.
           % try
                %try
                Exp = sdo.Experiment(obj.model);
                
                    %warning("failed to set up an experiment")
                Exp.OutputData = obj.signals;
                Exp.InitialStates = sdo.getStateFromModel(obj.model);
                %Exp.InputData = obj.input;
                %[Exp.InitialStates.Minimum] = zeros(1,numel(Exp.InitialStates));
                %[Exp.InitialStates.Free] = true;
                Sim = createSimulator(Exp);
                Sim.Name = obj.model; %I just needed somewhere to store the model name
                %[Sim.LoggingInfo.Signals.PropagatedName] = obj.signals.Name;
                
        end
        function v = getParameters(obj, max, min, Exp)
            p = sdo.getParameterFromModel(obj.model,obj.params);
            for i = 1:length(p)
                p(i).Maximum = max{i};
                p(i).Minimum = min{i};
            end
            s = getValuesToEstimate(Exp);
            v = [p;s];
        end

    end
end