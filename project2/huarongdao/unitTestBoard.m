classdef unitTestBoard < matlab.uitest.TestCase
    % Using the level "Test" to test
    
    methods(Test)
        function testChess(testCase)
            % click a chess that has no space around it, no action
            % button should be able to use.
            B = board;
            B.level = 5;
            pause(2);
            testCase.press(B.StartButton);
            pause(1);
            testCase.press(B.Zhangfei);
            pause(2);
            testCase.verifyEqual(B.UButton.Enable, 'off');
            testCase.verifyEqual(B.DButton.Enable, 'off');
            testCase.verifyEqual(B.LButton.Enable, 'off');
            testCase.verifyEqual(B.RButton.Enable, 'off');
            delete(B);
        end
        

        function testWin(testCase)
            % in Test level, CaoCao is just one step from the win state.
            % Choose Caocao, one action button should be able to use.
            % Move it, win UI should appear.
            B = board;
            B.level = 5;
            pause(2);
            testCase.press(B.StartButton);
            pause(1);
            testCase.press(B.Caocao);
            pause(2);
            testCase.verifyEqual(B.UButton.Enable, 'off');
            testCase.verifyEqual(B.RButton.Enable, 'off');
            testCase.verifyEqual(B.LButton.Enable, 'off');
            testCase.verifyEqual(B.DButton.Enable, 'on');
            testCase.press(B.DButton);
            delete(B)
        end
        
    end
end