classdef maneuver
    %MANEUVER Summary of this class goes here
    %   Detailed explanation goes here

    properties
        main_thruster_mask = [0 0 0 0 0 0 0 0]; %which thrusters perform the primary maneuver
        correction_thruster_mask = [0 0 0 0 0 0 0 0]; %which thrusters perform correction
        target_force = [0 0 0]';
        target_moment = [0 0 0]';
        thrust_wrench = zeros(3,8);
        moment_wrench = zeros(3,8);

        %TODO - add methods to tune correction_thruster_mask
        % - add some kind of UI to tune these easily
        % - add a designed init for simulating these
        % - allow for time varying maneuver intensity
    end

    methods
        function obj = maneuver(target_force,target_moment,thrust_wrench,moment_wrench)
            %MANEUVER Construct an instance of this class
            %   Detailed explanation goes here
            %enforce column
            target_force = target_force(:);
            target_moment = target_moment(:);

            obj.target_force = target_force;
            obj.target_moment = target_moment;
            obj.thrust_wrench = thrust_wrench;
            obj.moment_wrench = moment_wrench;

            obj.main_thruster_mask = buildMainMask(obj);
        end

        function FT_list_normalized = buildMainMask(obj)
            % 8 thrust values --> force and body moment
            % force and body moment --> 8 thrust values
            stack_force_and_moment = [obj.target_force;obj.target_moment]; %[6x1]
            stack_wrench = [obj.thrust_wrench;obj.moment_wrench];
            inverse_wrench = pinv(stack_wrench);

            % use the geometry of the thrusters to find the main mask
            FT_list = inverse_wrench*stack_force_and_moment; %[8x6][6x1] = [8x1]
            FT_list_normalized = round(FT_list./(max(abs(FT_list))),3);
        end
    end
end