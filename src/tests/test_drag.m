classdef test_drag < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_do_drag_flag(testCase)
            w = [1;2;3];
            dRb = [-4;-5;-6];
            drag_wrench = diag([1,2,3,4,5,6]);
            do_drag_flag = 0;
            [F_result, M_result] = drag(dRb, w, drag_wrench, do_drag_flag);
            expected = zeros(3,1);
            testCase.verifyEqual(F_result, expected);
            testCase.verifyEqual(M_result, expected);
        end

        function test_drag_FM(testCase)
            w = [1;2;3];
            dRb = [-4;-5;-6];
            drag_wrench = diag([1,2,3,4,5,6]);
            do_drag_flag = 1;
            [F_result, M_result] = drag(dRb, w, drag_wrench, do_drag_flag);
            testCase.verifyEqual(F_result, -diag([1,2,3])*(dRb.*abs(dRb)));
            testCase.verifyEqual(M_result, -diag([4,5,6])*(w.*abs(w)));
        end

        
    end

end