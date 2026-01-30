classdef test_setup_default_maneuvers2 < matlab.unittest.TestCase
    properties
        % Shared setup for the entire test class
        FT_wrench = [0 0 0 0 0.7071 0.7071 0.7071 0.7071;...
            0 0 0 0 0.7071 -0.7071 -0.7071 0.7071;...
            -1 -1 -1 -1 0 0 0 0];
        MT_wrench = [0.2032 -0.2032 0.2032 -0.2032 -0.0608 0.0608 0.0608 -0.0608;...
            0.2533 0.2533 -0.2522 -0.2522 0.0608 0.0608 0.0608 0.0608;...
            0 0 0 0 0.2155 -0.2155 0.2151 -0.2151];
    end

    methods (TestMethodSetup)
        % Setup for each test
        function suppressWarnings(testCase)
            testCase.addTeardown(@warning, 'on', 'all');
            warning('off', 'all');
        end
    end

    methods (Test)
        % Test methods

        function testRuns(testCase)
            FT_wrench = testCase.FT_wrench;
            MT_wrench = testCase.MT_wrench;
            run('setup_default_maneuvers2.m');
        end
    end

end