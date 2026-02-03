classdef test_parseMissionMatrix < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_start(testCase)
            %[command, current_maneuver_index, this_maneuver_end_time]
            mission_file = zeros(2,10);
            time = 0;
            current_maneuver_index = 1;
            this_maneuver_end_time = -1;
            received = parseMissionMatrix(mission_file,time,current_maneuver_index,this_maneuver_end_time);
            
            %command = [mode, maneuver id, maneuver duration, maneuver intensity,position waypoint, angle waypoint, time_in_maneuver]
            expected = [0 0 0 0 0 0 0 0 0 0 0];
            testCase.verifyEqual(received,expected);
        end

        function test_middle(testCase)
            %[command, current_maneuver_index, this_maneuver_end_time]
            mission_file = [1;2;3]*[1,2,3,4,5,6,7,8,9,10];
            time = 10;
            current_maneuver_index = 2;
            this_maneuver_end_time = 11;
            received = parseMissionMatrix(mission_file,time,current_maneuver_index,this_maneuver_end_time);
            
            %command = [mode, maneuver id, maneuver duration, maneuver intensity,position waypoint, angle waypoint, time_in_maneuver]
            expected = [2 4 6 8 10 12 14 16 18 20 5];
            testCase.verifyEqual(received,expected);
        end

        function test_transition(testCase)
            %[command, current_maneuver_index, this_maneuver_end_time]
            mission_file = [1;2;3]*[1,2,3,4,5,6,7,8,9,10];
            time = 10;
            current_maneuver_index = 2;
            this_maneuver_end_time = 10;
            received = parseMissionMatrix(mission_file,time,current_maneuver_index,this_maneuver_end_time);
            
            %command = [mode, maneuver id, maneuver duration, maneuver intensity,position waypoint, angle waypoint, time_in_maneuver]
            expected = [2 4 6 8 10 12 14 16 18 20 6];
            testCase.verifyEqual(received,expected);
        end

        function test_end(testCase)
            %[command, current_maneuver_index, this_maneuver_end_time]
            mission_file = [1;2;3]*[1,2,3,4,5,6,7,8,9,10];
            time = 30;
            current_maneuver_index = 4;
            this_maneuver_end_time = 0;
            received = parseMissionMatrix(mission_file,time,current_maneuver_index,this_maneuver_end_time);
            
            %command = [mode, maneuver id, maneuver duration, maneuver intensity,position waypoint, angle waypoint, time_in_maneuver]
            expected = [0 0 0 0 0 0 0 0 0 0 0];
            testCase.verifyEqual(received,expected);
        end
    end

end