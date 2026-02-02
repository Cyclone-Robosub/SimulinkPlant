classdef test_clamp < matlab.unittest.TestCase

    properties
        A
        B
    end


    methods (TestMethodSetup)
        % Setup for each test
        function vars(testCase)
            testCase.A = [-4 -3 -2;-1 0 1;2 3 4];
            testCase.B = [-2,-1,0,1,2];
        end
    end

    methods (Test)
        % Test methods

        function testClamp(testCase)
            A_new = clamp(testCase.A,-2,2);
            testCase.verifyEqual(A_new,[-2 -2 -2;-1 0 1;2 2 2]);
            B_new = clamp(testCase.B,0,0.9);
            testCase.verifyEqual(B_new,[0, 0, 0, .9, .9]);
        end
    end

end