classdef test_buoyancy < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_buoynacy_FM(testCase)
        Cbi = eye(3);
        rho = 2;
        V = 3;
        R_cm2cv = [1;2;3];

        [F_results, M_results] = buoyancy(Cbi, rho, V, R_cm2cv, 1);
        
        expected_F = [0;0;-rho*V*9.81];
        expected_M = cross(R_cm2cv,expected_F);

        testCase.verifyEqual(F_results, expected_F);
        testCase.verifyEqual(M_results, expected_M);

        end
    end

end