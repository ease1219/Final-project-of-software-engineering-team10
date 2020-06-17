classdef unitTestBoard < matlab.unittest.TestCase
    % Using the level "Test" to test
    methods(Test)
        function testStartButton(testCase)
            % press the Start button, the board should shows a game board
            % same as the setting.
            
        end
        
        function testNotMoveable(testCase)
            % click a chess that has no space around it, no action
            % button should be able to use.
        end
        
        function testCao(testCase)
            % in Test level, CaoCao is just one step from the win state.
            % Choose Caocao, one action button should be able to use.
            % Move it, win UI should appear.
            
        end
        
    end
end