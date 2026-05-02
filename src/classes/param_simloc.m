classdef param_simloc
    %PARAM_FROM_SIM Summary of this class goes here
    %   Class to orgnaize the information relating different paramters to
    %   their place in the simulation. This includes, how they are stored,
    %   what their submodel is, what's the blockpath to that submodel, what
    %   are their input and outputs

    properties
        params = {};
        data_path = {};
        submodel = "";
        signals = [];

    end

    methods
        function obj = param_simloc(results, params,data_path,submodel,signals, names, blockpath)
            %PARAM_FROM_SIM Construct an instance of this class
            %   Detailed explanation goes here
            obj.params = params;
            obj.data_path = data_path;
            obj.submodel = submodel;
            for i = 1:length(signals)
                obj.signals(i) = Simulink.SimulationData.Signal;
                obj.signals(i).Name = names(i);
                obj.signals(i).Blockpath  = blockpath;
                try
                    obj.signals(i).Values = find(results,names(i));
                catch
                    warning("Assigning signal data failed to resolve.")
                end
            end
        end

        function Exp = createExperiment(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            Exp = sdo.Experiment(obj.submodel);
            Exp.OutputData = obj.signals;
            Exp.InitialStates = sdo.getStateFromModel(obj.submodel);
        end
    end
end