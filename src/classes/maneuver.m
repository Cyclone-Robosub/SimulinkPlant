classdef maneuver
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        default_mask = zeros(8,1);
        correction_mask = zeros(8,1);
        total_mask = zeros(8,1);
        full_wrench = zeros(6,8);
        inv_wrench = zeros(8,6);
        intensity = 1;
        voltage = 14;

    end


    methods
        function obj = maneuver(FT_wrench,MT_wrench,targetFM)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here

            %stack the wrench matrices and calculate the inverse
            obj.full_wrench = [FT_wrench;MT_wrench];
            obj.inv_wrench = pinv(obj.full_wrench);

            %compute default mask
            if nargin >= 3
                targetFM = targetFM(:);
                obj.default_mask = obj.inv_wrench*targetFM;
                obj.default_mask = obj.normalizeMask(obj.default_mask);
            end

            obj.total_mask = obj.default_mask;

        end
        
        function obj = setVoltage(obj,v)
            obj.voltage = v;
        end
        
        function obj = setDefaultFM(obj,targetFM)
            targetFM = targetFM(:); %enforce column
            temp_mask = obj.inv_wrench*targetFM;
            temp_mask = obj.normalizeMask(temp_mask);
            obj.default_mask = temp_mask;
        end

        function [pwm,obj] = getPWM(obj)
            %{
            Returns the pwm command for the maneuver, assuming the maneuver
            has uniform intensity throughout. 

            TODO: Add additional t, and T argumenets to enable timevarying
            maneuvers.
            %}
            temp_mask = obj.default_mask + obj.correction_mask;
            temp_mask = obj.normalizeMask(temp_mask);
            obj.total_mask = temp_mask;
            %scale mask by intensity
            FT_list = obj.intensity.*obj.total_mask;
            pwm = forceToPWM(FT_list,obj.voltage);
            
        end
        

        function printManeuverData(obj)
            fprintf("Default Mask:\n")
            obj.default_mask'
            fprintf("Correction Mask:\n")
            obj.correction_mask'
        end

        function obj = addCorrectionFM(obj,addedFM)
            %{
            Adds the specified force and moment to the existing correction
            mask.
            %}
            addedFM = addedFM(:);
            mask_addition = obj.inv_wrench*addedFM;
            obj.correction_mask = obj.correction_mask + mask_addition;
            obj.total_mask = obj.correction_mask + obj.default_mask;
            
            
        end

        function obj = tweakThrusters(obj,tweak_mask,tweak_intensity)
            tweak_mask = tweak_mask(:);
            obj.correction_mask = obj.correction_mask + tweak_intensity*tweak_mask;
        end

        function obj = setCorrectionFM(obj,addedFM,correction_intensity)
            %{
            Overwrites the existing correction mask with a new correction
            mask based on the input force and motion.
            %}
            addedFM = addedFM(:);
            new_mask = obj.inv_wrench*addedFM;
            obj.correction_mask = correction_intensity.*obj.normalizeMask(new_mask);
            
            %update the total mask
            temp_mask = obj.default_mask + obj.correction_mask;
            temp_mask = obj.normalizeMask(temp_mask);
            obj.total_mask = temp_mask;
        end

        function norm_mask = normalizeMask(obj,temp_mask)
            max_val = max(abs(temp_mask));
            if(max_val > 1e-3)
                temp_mask = temp_mask(:);
                norm_mask = temp_mask./(max(abs(temp_mask)));
            else
                norm_mask = zeros(8,1);
            end
        end
    end
end