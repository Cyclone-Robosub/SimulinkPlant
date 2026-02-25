classdef test_attitude_transformation < matlab.unittest.TestCase

    properties
        q = [1;2;3;4]/norm([1,2,3,4]);
        eul = [pi/6; pi/4; pi/3];
        C = eye(3);
    end

    methods (TestClassSetup)
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_eulToRotm(testCase)
            result = eulToRotm(testCase.eul);
            result = result*[1;2;3];
            expected = eul2rotm([pi/3, pi/4, pi/6],'ZYX'); %compare to built in
            expected = ([1,2,3]*expected)';
            testCase.verifyEqual(result,expected,'RelTol',1e-4,'AbsTol',1e-4);
        end

        function test_quatToRotm(testCase)
            result = quatToRotm(testCase.q);
            result = result*[1;2;3];
            expected = quat2rotm([testCase.q(4),testCase.q(1),testCase.q(2),testCase.q(3)]);
            expected = ([1 2 3]*expected)';
            testCase.verifyEqual(result,expected,'RelTol',1e-4,'AbsTol',1e-4);
        end

        function test_quatToEul(testCase)
            result = quatToEul(testCase.q);
            result = eulToRotm(result);
            result = result*[1;2;3];

            expected = quat2rotm([testCase.q(4),testCase.q(1),testCase.q(2),testCase.q(3)]);
            expected = ([1 2 3]*expected)';
            testCase.verifyEqual(result,expected,'RelTol',1e-4,'AbsTol',1e-4);
        end

        function test_rotmToEul(testCase)
            result = rotmToEul(testCase.C);
            testCase.verifyEqual(result,[0;0;0],'RelTol',1e-4,'AbsTol',1e-4);
        end

        function test_rotmToQuat(testCase)
            result = rotmToQuat(testCase.C);
            testCase.verifyEqual(result,[0;0;0;1],'RelTol',1e-4,'AbsTol',1e-4)
        end

        function test_eulToQuat(testCase)
            result = eulToQuat(testCase.eul);
            result = quatToRotm(result);

            expected = eul2quat([testCase.eul(3), testCase.eul(2), testCase.eul(1)]);
            expected = quatToRotm([expected(2), expected(3), expected(4), expected(1)]);
            testCase.verifyEqual(result,expected,'RelTol',1e-4,'AbsTol',1e-4)


        end
    end

end