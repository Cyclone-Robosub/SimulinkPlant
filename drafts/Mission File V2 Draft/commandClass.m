classdef commandClass
    %COMMAND Summary of this class goes here
    %   Detailed explanation goes here

    properties
        identifier
        waypoint
        waypoint_tolerance
        hold_time
        object_identifier
        confidence
        trick_identifier
        timeout
        status = 'PEND'
        %{
        Valid status options are PEND, RUNN, SUCC, FAIL
        %}
    end

    methods
        function obj = commandClass(identifier, waypoint, waypoint_tolerance, hold_time, object_identifier, confidence, trick_identifier, timeout)
            % Construct an instance of this class
            %   Detailed explanation goes here
            obj.identifier = identifier;
            obj.waypoint = waypoint;
            obj.waypoint_tolerance = waypoint_tolerance;
            obj.hold_time = hold_time;
            obj.object_identifier = object_identifier;
            obj.confidence = confidence;
            obj.trick_identifier = trick_identifier;
            obj.timeout = timeout;
        end

    end
end