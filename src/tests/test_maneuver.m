classdef test_maneuver < matlab.unittest.TestCase
    
    properties 
        maneuver
    end

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test

        function createManeuver(testCase)
            testCase.addTeardown(@warning, 'on', 'all');
            warning('off', 'all');

            ID = 0;
            maxThrusterForce = 10;
            name = "test";
            FT_wrench = [0 0 0 0 0.7071 0.7071 0.7071 0.7071;...
                0 0 0 0 0.7071 -0.7071 -0.7071 0.7071;...
                -1 -1 -1 -1 0 0 0 0];
            MT_wrench = [0.2032 -0.2032 0.2032 -0.2032 -0.0608 0.0608 0.0608 -0.0608;...
                0.2533 0.2533 -0.2522 -0.2522 0.0608 0.0608 0.0608 0.0608;...
                0 0 0 0 0.2155 -0.2155 0.2151 -0.2151];
            testCase.maneuver = maneuver2(ID,maxThrusterForce,FT_wrench,MT_wrench,name);
        end

        
    end

    methods (Test)
        % Test methods

        function testsetFTList(testCase)
            testCase.maneuver = testCase.maneuver.setFTList(5*ones(8,1));
            testCase.verifyEqual(testCase.maneuver.FT_list,5*ones(8,1));
        end

        function testaddFTList(testCase)
            testCase.maneuver = testCase.maneuver.setFTList(5*ones(8,1));
            testCase.maneuver = testCase.maneuver.addFTList(ones(8,1));
            testCase.verifyEqual(testCase.maneuver.FT_list,6*ones(8,1));
        end

        function testConstrainUpper(testCase)
            testCase.maneuver = testCase.maneuver.setFTList(5*ones(8,1));
            testCase.maneuver = testCase.maneuver.addFTList(6*ones(8,1));
            testCase.verifyEqual(testCase.maneuver.FT_list,10*ones(8,1));
        end

        function testConstrainLower(testCase)
            testCase.maneuver = testCase.maneuver.setFTList(-5*ones(8,1));
            testCase.maneuver = testCase.maneuver.addFTList(-6*ones(8,1));
            testCase.verifyEqual(testCase.maneuver.FT_list,-10*ones(8,1));
        end

        function testSetIntensity(testCase)
            testCase.maneuver = testCase.maneuver.setIntensity(0.5);
            testCase.verifyEqual(testCase.maneuver.intensity,0.5);
        end

        function testSetMask(testCase)
            testCase.maneuver = testCase.maneuver.setMask(zeros(8,1));
            testCase.verifyEqual(testCase.maneuver.fm,zeros(6,1));
            testCase.verifyEqual(testCase.maneuver.FT_list,zeros(8,1));
        end

        function testsetMask(testCase)
            testCase.maneuver = testCase.maneuver.setMask(ones(8,1));
            testCase.verifyEqual(testCase.maneuver.FT_list,10*ones(8,1));
        end

        function testsetForce(testCase)
            testCase.maneuver = testCase.maneuver.setForce(ones(6,1));
            expected = pinv([testCase.maneuver.FT_wrench;testCase.maneuver.MT_wrench])*ones(6,1);
            testCase.verifyEqual(testCase.maneuver.FT_list,expected,'AbsTol',1e-3);

            testCase.maneuver = testCase.maneuver.setForce(1000*ones(6,1));
            expected = (10*[1,-1,1,-1,1,-1,1,-1]');
            testCase.verifyEqual(testCase.maneuver.FT_list,expected,'AbsTol',1e-3);

        end

        function testaddForce(testCase)
            testCase.maneuver = testCase.maneuver.setForce(ones(6,1));
            testCase.maneuver = testCase.maneuver.addForce(ones(6,1));
            testCase.verifyEqual(testCase.maneuver.fm,2*ones(6,1),'AbsTol',1e-3);

            expected = [testCase.maneuver.FT_wrench;testCase.maneuver.MT_wrench]*(10*[1,-1,1,-1,1,-1,1,-1]');
            testCase.maneuver = testCase.maneuver.addForce(1000*ones(6,1));
            testCase.verifyEqual(testCase.maneuver.fm,expected,'AbsTol',1e-3);
        end


    end

end