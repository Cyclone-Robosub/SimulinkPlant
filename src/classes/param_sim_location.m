classdef param_sim_location
    %PARAM_FROM_SIM Summary of this class goes here
    %   Class to orgnaize the information relating different paramters to
    %   the signals which we estimate them from.

    properties
        params = {};
        model = "";
        signals = [Simulink.SimulationData.Signal];
        blockpath = "";
        %input = [Simulink.SimulationData.Signal];
        input = [Simulink.SimulationData.Signal];
        iState = {};
    end

    methods
        % Need to change results variable to be some sort of list to support
        % multiple experiments
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
            
            for i = 1:8
                obj.input(i) = Simulink.SimulationData.Signal;
                obj.input(i).PortIndex = i;
                obj.input(i).PortType = "inport";
                obj.input(i).Name = sprintf("pwm%d",i-1);
                obj.input(i).BlockPath = strcat("Dynamics_SIM_EST/",obj.input(i).Name);
                obj.input(i).Values = timeseries(double(results.pwms.Data(:,i)),double(results.pwms.Time));
            end
            
            % obj.input = double(results.pwms.Data);
            %obj.input = results.
            

                %initial intertial position
                xi_0 = squeeze(results.Ri.Data(1,1,1));yi_0 = squeeze(results.Ri.Data(2,1,1)); zi_0 = squeeze(results.Ri.Data(3,1,1));
                Ri_0 = [xi_0; yi_0; zi_0];

                %initial intertial velocity
                ui_0 = squeeze(results.dvl_vel.Data(1,1,1)); vi_0 = squeeze(results.dvl_vel.Data(2,1,1)); wi_0 = squeeze(results.dvl_vel.Data(3,1,1));
                dRi_0 = [ui_0; vi_0; wi_0];

                %initial euler angles
                phi_0 = squeeze(results.Eul.Data(1,1,1)); theta_0 = squeeze(results.Eul.Data(2,1,1)); psi_0 = squeeze(results.Eul.Data(3,1,1));
                Eul_0 = [phi_0; theta_0; psi_0]; %[roll, pitch, yaw]

                %other attitude representations
                %Cib_0 = eulToRotm(Eul_0);
                q_0 = eulToQuat(Eul_0); %[vector; scalar]

                %initial angular velocity
                %wbx_0 = 0; wby_0 = 0; wbz_0 = 0;
                wbx_0 = squeeze(results.wb.Data(1,1,1)); wby_0 = squeeze(results.wb.Data(2,1,1)); wbz_0 = squeeze(results.wb.Data(3,1,1));
                wb_0 = [wbx_0; wby_0; wbz_0];

                %pack initial state
                X0 = [Ri_0;q_0;dRi_0;wb_0];
            obj.iState{1} = X0;
            obj.iState{2} = [0 0 0];
        end

        function [Exp,Sim] = createExperiments(obj)
            %createExperiment creates expeiment from a param_sim_location
            %   param_simloc contains information for the parameters to be
            %   estimated as well as what signals they are estimated from.
            %   This method then uses that information to make an sdo
            %   Experiment that will be used for parameter estimation.
                Exp = sdo.Experiment(obj.model);
                Exp.OutputData = obj.signals;
                Exp.InitialStates = sdo.getStateFromModel(obj.model);
                % Exp.InputData = obj.input.Values.Data;
                Exp.InputData = [obj.input(1).Values.Data,...
                                 obj.input(2).Values.Data,...
                                 obj.input(3).Values.Data,...
                                 obj.input(4).Values.Data,...
                                 obj.input(5).Values.Data,...
                                 obj.input(6).Values.Data,...
                                 obj.input(7).Values.Data,...
                                 obj.input(8).Values.Data,...
                                 1500.*ones(size(obj.input(2).Values.Data))];

                %INITIAL STATES EXCLUSIVE TO DYNAMICS SIM
                    X0 = sdo.getStateFromModel(obj.model);
                    X0(1).Value = obj.iState{1};
                    X0(2).Value = obj.iState{2};
                    X0(1).Free = false;
                    X0(2).Free = false;
                    Exp.InitialStates= [X0(1);X0(2)];
                Sim = createSimulator(Exp);
                Sim.Inputs = obj.input;
                Sim.Name = obj.model; %I just needed somewhere to store the model name
                %[Sim.LoggingInfo.Signals.PropagatedName] = obj.signals.Name;
                
        end

        function simulator = createSim(experiments)
            simulator = createSimulator(experiments(1));
            for i = 1:numel(experiments)
                simulator = createSimulator(experiments(i), simulator);
            end
            simulator.Inputs = obj.input;
            simulator.Name = obj.model;
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