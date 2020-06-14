close all
clear all 
EP = elevatorProcessor;
F1app = Floor_1_UI;
F2app = Floor_2_UI;
F3app = Floor_3_UI;
LE = singleElevator;
LE.NO = 0;
LE.floorHeight = EP.floorHeight;
LEapp = Elevator_UI;
LEapp.NO = 0;
LEapp.EleNO.Text = 'Left';
RE = singleElevator;
RE.NO = 1;
RE.floorHeight = EP.floorHeight;
REapp = Elevator_UI;
REapp.NO = 1;
REapp.EleNO.Text = 'Right';

EP.LeftElevatorApp = LEapp;
EP.RightElevatorApp = REapp;
EP.FirstFloorApp = F1app;    
EP.SecondFloorApp = F2app;
EP.ThirdFloorApp = F3app;
EP.leftElevator = LE;
EP.rightElevator = RE;

F1app.elevatorProcessor = EP;
F2app.elevatorProcessor = EP;
F3app.elevatorProcessor = EP;

LE.elevatorProcessor = EP;
LE.ElevatorUI = LEapp;

RE.elevatorProcessor = EP;
RE.ElevatorUI = REapp;

LEapp.elevatorProcessor = EP;
LEapp.elevator = LE;
REapp.elevatorProcessor = EP;
REapp.elevator = RE;

tt = timer;
tt.StartDelay = 1;
tt.ExecutionMode = 'fixedRate';
tt.Period = EP.dt;
tt.TasksToExecute = inf;
tt.TimerFcn = @(~,~)running(LE,RE,EP);
start(tt)

function running(LE,RE,EP)
    %tic
    switch LE.door
        case 0
            LE.doorClosed(EP.dt);
        case 1
            LE.doorOpened(EP.dt);
        case 2
            LE.doorOpening(EP.dt);
        case 3
            LE.doorClosing(EP.dt);
    end
    
    switch RE.door
        case 0
            RE.doorClosed(EP.dt);
        case 1
            RE.doorOpened(EP.dt);
        case 2
            RE.doorOpening(EP.dt);
        case 3
            RE.doorClosing(EP.dt);
    end
    %RE.h
    %toc
end

