classdef unitTestStarter < matlab.unittest.TestCase
    methods(Test)
        function testBeginning(testCase)
            % After open the Starter, there should be no Start button and
            % the level chooser is "level".
            
        end
        
        function testChooseLevel(testCase)
            % Choose a level, the Start button should appear and the level
            % should be the chosen value.
            
        end
        
        function testStartButton(testCase)
            % After the level is chosen, press the Start button, a game
            % board should appear, and the board's level should be the 
            % chosen level.(How?)
            
        end
        
    end
end