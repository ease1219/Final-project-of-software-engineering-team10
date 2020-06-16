% testcase 横刀立马 solver
% please run this test on a 1080p resolution screen without any scaling, or
% the mouse will be offset

clear all;

import java.awt.Robot;
import java.awt.event.*;


runtest();

function runtest()
    xlist = [250,350,450,550];
    ylist = [885,785,685,585,485];
    up = [400,970];
    down = [400,1010];
    left = [380,990];
    right = [420,990];
    [xx,yy,dd] = setco();
    
    game = Starter;
    
    robot = java.awt.Robot;
    pause(3);
    robot.mouseMove(370,855); % choose level
    pause(1);
    pressbutton(robot);
    robot.mouseMove(300,700); % choose 横刀立马
    pause(1);
    pressbutton(robot);
    pause(3);
    robot.mouseMove(280,905); % startbutton
    pause(1);
    pressbutton(robot);
    pause(3);
    robot.mouseMove(400,500); % start button place
    pause(3);
    pressbutton(robot);
    pause(1);
    
    for i = 1:length(xx)
        movechess(robot,xx(i),yy(i),dd(i),xlist,ylist,up,down,left,right);
    end

end

function [xx,yy,dd] = setco()
    runXco1 = [4,4,3,2,1,1,2,2,3,3,3,3,3,3,2];
    runYco1 = [1,2,3,2,2,1,1,2,3,3,2,3,1,2,1];
    runDir1 = ["left","down","right","down","right","up","left","down","left","left","up","right","up","up","right"];
    runXco2 = [1,2,1,3,2,4,3,3,4,2,3,1,2,1];
    runYco2 = [2,2,3,3,3,3,3,1,1,1,1,1,1,2];
    runDir2 = ["right","down","down","left","left","left","left","up","up","right","right","right","right","down"];
    runXco3 = [2,2,3,4,4,4,3,1,1,1,1,1,2,2,2];
    runYco3 = [3,2,2,2,4,4,4,4,3,4,2,3,2,4,4];
    runDir3 = ["down","left","left","left","down","down","right","right","up","up","up","up","left","down","down"];
    runXco4 = [3,4,4,3,3,3,4,3,2,2,1,2,3,2];
    runYco4 = [4,3,3,2,1,2,1,1,1,1,2,2,3,3];
    runDir4 = ["left","up","up","right","up","up","left","up","right","right","down","down","left","left"];
    runXco5 = [2,1,2,1,1,1,1,1,1,2,3,2,2];
    runYco5 = [4,5,5,4,5,3,4,2,2,1,2,2,3];
    runDir5 = ["down","right","right","up","right","up","up","up","up","left","left","down","down"];
    runXco6 = [3,3,4,4,4,2,2,2,1,1,1,2];
    runYco6 = [5,4,4,3,3,2,4,5,5,3,2,1];
    runDir6 = ["down","left","left","up","up","right","down","down","right","up","up","left"];
    runXco7 = [2,2,3,4,4,3,2,2,1,1,1,2,3,3,3,3];
    runYco7 = [3,2,2,4,4,4,4,5,4,3,3,2,4,3,5,4];
    runDir7 = ["down","down","left","down","down","right","right","right","right","up","up","left","down","down","down","down"];
    runXco8 = [4,4,4,3,4,3,2,3,1,2,1,3,2,4,3];
    runYco8 = [4,3,3,2,2,1,1,1,1,1,2,3,3,3,3];
    runDir8 = ["left","up","up","right","up","up","right","right","right","right","down","left","left","left","left"];
    runXco9 = [3,3,3,1];
    runYco9 = [2,1,2,1];
    runDir9 = ["up","up","right","right"];
    xx = [runXco1,runXco2,runXco3,runXco4,runXco5,runXco6,runXco7,runXco8,runXco9];
    yy = [runYco1,runYco2,runYco3,runYco4,runYco5,runYco6,runYco7,runYco8,runYco9];
    dd = [runDir1,runDir2,runDir3,runDir4,runDir5,runDir6,runDir7,runDir8,runDir9];
end

function movechess(robot,x,y,direction,xlist,ylist,up,down,left,right)
    robot.mouseMove(xlist(x),ylist(y));
    pause(0.8);
    pressbutton(robot);
    switch direction
        case 'up'
            robot.mouseMove(up(1),up(2));
        case 'down'
            robot.mouseMove(down(1),down(2));
        case 'left'
            robot.mouseMove(left(1),left(2));
        case 'right'
            robot.mouseMove(right(1),right(2));
    end
    pause(0.5);
    pressbutton(robot);
end

function pressbutton(robot)
    robot.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);
    robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
end