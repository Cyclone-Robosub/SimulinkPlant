classdef maneuver2
%{
The feedforward (FF) controller works by specifying the ID and intensity of 
a maneuver in the mission file. When init is ran, each instance of the
maneuver class is used to produce a structure of relevant maneuver data.
The whole class cannot be passed into the controller because many class 
features are incompatible with Simulink. When a specific mission file line 
is executed, the FF controller matches the maneuver ID to the maneuver ID 
field of the maneuver data structure from the instance of the maneuver 
class. 

This maneuver structure is used then used to command a specific set of
structures to a set of 8 constants values. The applied thrusts are
uniformly scaled by the intensity factor for the maneuver. 

To use this class, repeatedly run a single maneuver for a few seconds and
observe the performance. Then use setForce, addForce, setMask,
setFTList, addFTList, setIntensity, and setMaxManeuverForce to tune the
maneuver. 

As a rule, "sets" OVERWRITE the currently saved FTList for this maneuver,
while "adds" convert the input to 8 forces then ADD force to the FTList. In
either case, the forces are hard capped at the max thruster force and the
mask is NOT re-normalized after edits, which is a change from the previous
versions of this class.
%}

    properties
        FT_list = zeros(8,1);
        fm = zeros(6,1);
        FT_wrench = zeros(3,8);
        MT_wrench = zeros(3,8);
        wrench = zeros(6,8);
        maxManeuverForce = 0;
        intensity = 1;
        ID = 0; 
        name = "Unnamed Maneuver"
    end

    methods
        function obj =  maneuver2(ID, maxManeuverForce, FT_wrench, MT_wrench, varargin)
            %Constructor
            obj.ID = ID;
            obj.maxManeuverForce = maxManeuverForce;
            obj.FT_wrench = FT_wrench;
            obj.MT_wrench = MT_wrench;
            obj.wrench = [FT_wrench;MT_wrench];

            if(~isempty(varargin)) %set the name if user specified one
                obj.name = varargin{1};
            end
        end

        function obj = setFTList(obj,FT_list)
            %{
            Constrains user provided FT_list to allowable bounds then sets
            this maneuvers FT_list.
            %}
            obj.FT_list = obj.constrain(FT_list);

            %set fm
            obj.fm = obj.wrench*obj.FT_list;
        end

        function obj = addFTList(obj,FT_list_add)
            %{
            This function adds the user specified addition to the FT_list,
            then re-constrains it. The function also offers a warning if
            the addition will put thruster values outside the
            maxManeuverForce.
            %}
            FT_list = obj.FT_list + FT_list_add;
            obj.warnOutOfBoundFT_list(FT_list);
            obj.FT_list = constrain(obj,FT_list);

            %set fm
            obj.fm = obj.wrench*obj.FT_list;
        end
        
        function obj = setForce(obj,fm)
            %{
            This function uses the MT_wrench and FT_wrench to calculate the
            FT_list necessary to produce the 6x1 [force;moment] vector fm.
            After this force vector is calculated it is constrained to the
            allowable bounds.
            %}
            FT_list = pinv(obj.wrench)*fm;
            obj.warnOutOfBoundFT_list(FT_list);
            obj.FT_list = obj.constrain(FT_list);
            
            %calculate the actual force and moment after constraint
            obj.fm = obj.wrench*obj.FT_list;
        end

        function obj = addForce(obj,fm_add)
            %{
            This function adds the specified addition to the force and
            moment pair for this class. The result is used to generate a
            constrained FT_list. 
            %}
            FT_list = pinv(obj.wrench)*(obj.fm + fm_add);
            obj.warnOutOfBoundFT_list(FT_list);
            obj.FT_list = obj.constrain(FT_list);

            %calculate the actual force and moment after constraint
            obj.fm = obj.wrench*obj.FT_list;
        end

        function obj = setMask(obj,mask)
            %{
            Use of this function is less precise then setFTList and
            setForce, but it can be used to tune maneuvers with no
            knowledge of the actual force and moment on the vehicle, only
            the proportional thruster force. This may be helpful for some
            users. 

            Each element of the mask is expected to be on [-1,1], but this
            is not strictly necessary as the resulting FT_list will be
            constrained anyway.
            %}
            FT_list = obj.maxManeuverForce*mask;
            obj.warnOutOfBoundFT_list(FT_list);
            obj.FT_list = obj.constrain(FT_list);

            obj.fm = obj.wrench*obj.FT_list;


        end
        
        function obj = setMaxManeuverForce(obj,maxForce)
            obj.maxManeuverForce = maxForce;
        end

        function obj = setIntensity(obj, intensity)
            %It is recommended to leave this value at 1.
            obj.intensity = intensity;
        end
        
        function warnOutOfBoundFT_list(obj,FT_list)
            for k = 1:length(FT_list)
                if(FT_list(k)>obj.maxManeuverForce)
                    warning("FT_list index %i of maneuver (%i, %s) has a force of %f. \nThis exceeds the maneuver limit of %s and will be constrained.",k,obj.ID,obj.name,FT_list(k),obj.maxManeuverForce);
                elseif(FT_list(k)<-obj.maxManeuverForce)
                    warning("FT_list index %i of maneuver (%i, %s) has a force of %f. \nThis exceeds the maneuver limit of %s and will be constrained.",k,obj.ID,obj.name,FT_list(k),-obj.maxManeuverForce);
                end
            end
        end

        function out = constrain(obj,FT_list)
            %{
            Constrains the provided FT_list from -maxManeuverForce to
            +maxManeuverForce. Only allows symmetrical bounds.
            %}
            for k = 1:length(FT_list)
                if(FT_list(k)>obj.maxManeuverForce)
                    FT_list(k) = obj.maxManeuverForce;
                elseif(FT_list(k)<-obj.maxManeuverForce)
                    FT_list(k) = -obj.maxManeuverForce;
                end
                out = FT_list;
            end
        end
    
        function out = getManeuverStructure(obj)
            %{
            This function packs all the data from this maneuver into a
            simulink-friendly structure.
            %}
            out.FT_list = obj.FT_list;
            out.intensity = obj.intensity;
            out.ID = obj.ID;
            out.name = obj.name;
        end
    end
end