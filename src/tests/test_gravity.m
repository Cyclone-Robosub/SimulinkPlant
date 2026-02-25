classdef test_gravity < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_do_gravity_flag(testCase)
            Cbi = eye(3);
            m = 1;
            do_gravity_flag = 0;
            [F_result, M_result] = gravity(Cbi, m, do_gravity_flag);
            testCase.verifyEqual(F_result,zeros(3,1));
            testCase.verifyEqual(M_result, zeros(3,1));
        end

        function test_gravity_FM(testCase)
            Cbi = eye(3);
            m = 2;
            do_gravity_flag = 1;
            [F_result, M_result] = gravity(Cbi, m, do_gravity_flag);
            testCase.verifyEqual(F_result,[0;0;9.81*2]);
            testCase.verifyEqual(M_result,zeros(3,1));
        end
    end

end