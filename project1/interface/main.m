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
RE = singleElevator;
RE.NO = 1;
RE.floorHeight = EP.floorHeight;
REapp = Elevator_UI;
REapp.NO = 1;

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