classdef test_FFCmdToForce2 < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_empty_FF_maneuver_data(testCase)
            FF_maneuver_data = [];
            max_thruster_force = 1;
            defined_maneuvers = [0 0 0 0 0 0 0 0 1 1];
            result = FFCmdToForce2(FF_maneuver_data,max_thruster_force,defined_maneuvers);
            testCase.verifyEqual(result,zeros(8,1));
        end

        function test_empty_defined_maneuvers(testCase)
            FF_maneuver_data = [1 1 1 1];
            max_thruster_force = 1;
            defined_maneuvers = [];
            result = FFCmdToForce2(FF_maneuver_data,max_thruster_force,defined_maneuvers);
            testCase.verifyEqual(result,zeros(8,1));
        end

        function test_maneuver(testCase)
            FF_maneuver_data = [2,0,1,0];
            max_thruster_force = 5;
            defined_maneuvers = [1 2 3 4 5 6 7 8 1 2];
            result = FFCmdToForce2(FF_maneuver_data,max_thruster_force,defined_maneuvers);
            testCase.verifyEqual(result,[1 2 3 4 5 5 5 5]);

            FF_maneuver_data = [2,0,1,0];
            max_thruster_force = 5;
            defined_maneuvers = [-1 -2 -3 -4 -5 -6 -7 -8 1 2];
            result = FFCmdToForce2(FF_maneuver_data,max_thruster_force,defined_maneuvers);
            testCase.verifyEqual(result,[-1 -2 -3 -4 -5 -5 -5 -5]);
        end
    end

end