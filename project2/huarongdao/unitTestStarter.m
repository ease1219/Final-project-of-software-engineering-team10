classdef unitTestStarter < matlab.uitest.TestCase
    properties
        App
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.App = Starter;
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods(Test)
        function testChooseLevel(testCase)
            % State: beginning
            % Input: choose a level
            % Expected Output: 1) Start button appears; 2) Starter.level is
            % the chosen level value.
            testCase.choose(testCase.App.Select,"test");
            pause(2);
            testCase.verifyEqual(testCase.App.STARTButton.Visible,'on')
            testCase.verifyEqual(testCase.App.level,5)
        end
        
        function testStartButton(testCase)
            % After the level is chosen, press the Start button, a game
            % board should appear, and the board's level should be the 
            % chosen level.(How?)
            testCase.choose(testCase.App.Select,"test");
            pause(2);
            testCase.press(testCase.App.STARTButton);
            pause(1);
            testCase.verifyTrue(testCase.App.pressed)
            close all;
        end
        
    end
end