classdef test_importMissionCSV < matlab.unittest.TestCase

    properties 
        path1
        path2
        path3
    end
    methods (TestClassSetup)
        % Shared setup for the entire test class
        function setup(testCase)
            if(~exist('prj_path_list','var')) %refreshes the file path in case clear all was called
                prj_path_list = getProjectPaths();
            end
            testCase.path1 = fullfile(prj_path_list.test_path,"test_mission_file1.txt");
            testCase.path2 = fullfile(prj_path_list.test_path,"test_mission_file2.txt");
            testCase.path3 = fullfile(prj_path_list.test_path,"test_mission_file3.txt");
        end
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function test_good_file(testCase)
            result = importMissionCSV(testCase.path1);
            expected = [ones(5,10);zeros(95,10)];
            testCase.verifyEqual(result,expected);
        end

        function test_broken_file(testCase)
            result = importMissionCSV(testCase.path2);
            expected = [ones(4,10);zeros(96,10)];
            testCase.verifyEqual(result,expected);
        end

        function test_too_long_file(testCase)
            result = importMissionCSV(testCase.path3)
            expected = ones(100,10);
            testCase.verifyEqual(result,expected);
        end
    end

end