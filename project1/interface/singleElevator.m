classdef singleElevator < handle
   properties
       NO                       % the number of elevator. 0 is the left, 1 is the right.
       speed = 1.0;             % the max speed of the elevator(m/s)
       acceleration = 0.5;      % the acceleration(m/s^2)
       v = 0.0;                 % real-time speed
       a = 0.0;                 % real-time acceleration
       h = 3.0;                 % real-time height, floor 1 is 3m high.
       t = 0.0;                 % time counter for some situations
       direction = 0            % up(1) or down(-1), if no command, be zero
       currentFloor = 1;        % real-time, which floor the elevator is at.
       defaultFloor = 1;        % go to default floor after a period of time without running
       door = 0;                % 0 means door is closed. 1 means opened, 2 means during opening, 3 means during closing
       floorHeight              % height between two floor(m), will be copied from processor
       switchTime = 1.0;        % time needed for door opening or closing
       doorKeepTime = 3.0;      % after open the door, keep the door open for a short period of time(s)
       limitTime = 60.0        % time keep in the floor after finally usage before let it go to default floor(s)
       upRequest=[];            % used to store the requests of going up
       downRequest=[];          % used to store the requests of going down
       temp = [];               % some requests cannot be finished immediately, store them in temp.
       open = 0;                % a parameter to record whether there is a request of open the door
       close = 0;               % a parameter to record whether there is a request of closing the door
       
       elevatorProcessor        % the processor
       ElevatorUI               % UI
   end
   
   methods
       function addUpRequest(process,aim)
           process.upRequest = unique([process.upRequest,aim]);
       end
       
       function addDownRequest(process,aim)
           mmm = unique([process.downRequest,aim]);
           process.downRequest = flip(mmm);
       end
       
       % Deal with the request. I try to avoid the request that elevator
       % can not handle in one single run to simplify the running process.
       function receiveReq(process,aim,direction)
           % time that the elevator need to become v=0 from now
           tn = abs(process.v / process.acceleration);
           % calculate the distance needed to become v=0
           s = abs(process.v * tn) - 0.5 * process.acceleration * tn * tn;
           % the true distance between elevator and the aim floor
           dist = abs(aim*process.floorHeight-process.h);
           if s <= dist % elevator is able to stop at aim floor 
              if direction == -1
                  process.addDownRequest(aim);
              elseif direction == 1
                  process.addUpRequest(aim);
              end
           else % not able to stop at aim floor, store the request in temp
               process.temp = unique([process.temp,aim]);
           end
       end
       
       % calculate the elevator's velocity and height, then display the
       % information in the UI.
       function calculateAndDisplay(process,dt)
           process.v = process.v + dt*process.a;
           process.h = process.h + process.v*dt + 0.5*process.a*dt*dt;
           process.ElevatorUI.Height.Text = num2str(process.h);
           if process.h >= 3 && process.h < 4.5 && process.currentFloor ~= 1
               process.currentFloor = 1;
               process.ElevatorUI.displayFloorMessage("1");
           elseif process.h >= 4.5 && process.h < 7.5 && process.currentFloor ~= 2
               process.currentFloor = 2;
               process.ElevatorUI.displayFloorMessage("2");
           elseif process.h >= 7.5 && process.h <= 9 && process.currentFloor ~= 3
               process.currentFloor = 3;
               process.ElevatorUI.displayFloorMessage("3");
           end
           switch process.direction
               case 1
                   process.ElevatorUI.displayDirectionMessage("��");
                   process.elevatorProcessor.displayInfo(process.NO, num2str(process.currentFloor),"��");
               case -1
                   process.ElevatorUI.displayDirectionMessage("��");
                   process.elevatorProcessor.displayInfo(process.NO, num2str(process.currentFloor),"��");
               case 0
                   process.ElevatorUI.displayDirectionMessage(" ");
                   process.elevatorProcessor.displayInfo(process.NO, num2str(process.currentFloor)," ");
           end
       end
       
       % while door is opening(door=2)
       function doorOpening(process,dt)
           if process.open == 1 || process.close == 1
               process.open = 0;
               process.close = 0;
               process.ElevatorUI.Lamp_Close.Color = [0.9,0.9,0.9];
               process.ElevatorUI.Lamp_Open.Color = [0.9,0.9,0.9];
           end
           if process.t < process.switchTime
               process.t = process.t + dt;
           else
               process.t = 0;
               process.door = 1;
           end
       end
       
       % while door is closing(door=3)
       function doorClosing(process,dt)
           if process.close == 1
               process.close = 0;
               process.ElevatorUI.Lamp_Close.Color = [0.9,0.9,0.9];
           end
           if process.open == 1
               process.open = 0;
               process.ElevatorUI.openInsideDoor();
               process.elevatorProcessor.openOutsideDoor(process.currentFloor, process.NO, process.direction);
               process.ElevatorUI.Lamp_Open.Color = [0.9,0.9,0.9];
               process.door = 2;
               process.t = 0;

           elseif process.t < process.switchTime
               process.t = process.t + dt;
           else
               process.t = 0;
               process.door = 0;
           end
       end
       
       % while door has been opened(door=1)
       function doorOpened(process,dt)
           if process.open == 1
               process.t = 0;
               process.open = 0;
               process.ElevatorUI.Lamp_Open.Color = [0.9,0.9,0.9];
           end
           if process.close == 1
               process.t = 0;
               process.close = 0;
               process.ElevatorUI.Lamp_Close.Color = [0.9,0.9,0.9];
               process.door = 3;
               process.ElevatorUI.closeInsideDoor();
               process.elevatorProcessor.closeOutsideDoor(process.currentFloor,process.NO);
               
           elseif process.t < process.doorKeepTime
               process.t = process.t + dt;
           else
               process.t = 0;
               process.door = 3;
               process.ElevatorUI.closeInsideDoor();
               process.elevatorProcessor.closeOutsideDoor(process.currentFloor,process.NO);
           end
       end
       
       % while door has been closed(door=0)
       function doorClosed(process,dt)
           if process.close == 1
               process.close = 0;
               process.ElevatorUI.Lamp_Close.Color = [0.9,0.9,0.9];
           end
           if process.open == 1
               if process.v == 0
                   process.door = 2;
                   process.open = 0;
                   process.ElevatorUI.Lamp_Open.Color = [0.9,0.9,0.9];
                   process.t = 0;
                   process.ElevatorUI.openInsideDoor();
                   process.elevatorProcessor.openOutsideDoor(process.currentFloor, process.NO, process.direction);
               else
                   process.open = 0;
                   process.ElevatorUI.Lamp_Open.Color = [0.9,0.9,0.9];
               end
           else
               
               switch process.direction
                   case 1 % up
                       process.upFunction(dt);
                   case -1 % down
                       process.downFunction(dt);
                   case 0 % no direction
                       process.stayFunction(dt);
               end
           end
       end
       
       % elevator has "up" property (direction = 1)
       function upFunction(process,dt)
           if ~isempty(process.upRequest) % up request is not empty
               dist = process.upRequest(1)*process.floorHeight - process.h;
               if dist >=-0.02 && dist <= 0.02
                   process.a = 0;
                   process.v = 0;
                   process.ElevatorUI.openInsideDoor();
                   process.ElevatorUI.closeLight(process.currentFloor);
                   process.elevatorProcessor.openOutsideDoor(process.currentFloor,process.NO,1);
                   process.door = 2;
                   process.t = dt;
                   process.upRequest(1) = [];
               elseif dist>0.02 && dist<1.01 && process.v >0
                   process.a = -process.acceleration;
               else
                   if process.v >= process.speed && process.v <= process.speed+0.025
                       process.a = 0;
                   elseif abs(process.v) < process.speed
                       process.a = process.acceleration;
                   end
               end
               process.calculateAndDisplay(dt);
               
           elseif ~isempty(process.downRequest) && process.downRequest(1) >= process.currentFloor
               dist = process.downRequest(1)*process.floorHeight - process.h;
               if dist >=-0.02 && dist <= 0.02
                   process.direction = -1;
                   process.a = 0;
                   process.v = 0;
                   process.ElevatorUI.openInsideDoor();
                   process.ElevatorUI.closeLight(process.currentFloor);
                   process.elevatorProcessor.openOutsideDoor(process.currentFloor,process.NO,-1);
                   process.door = 2;
                   process.t = dt;
                   process.downRequest(1) = [];
               elseif dist>0.02 && dist<1.01 && process.v >0
                   process.a = -process.acceleration;
               else
                   if process.v >= process.speed && process.v <= process.speed+0.025
                       process.a = 0;
                   elseif abs(process.v) < process.speed
                       process.a = process.acceleration;
                   end
               end
               process.calculateAndDisplay(dt);
                   
           else % elevator's up request is empty and the highest down request is not higher than current
               % total down requests
               united = flip(unique([process.temp, process.elevatorProcessor.tempDown, process.downRequest]));
               if ~isempty(united)
                   process.temp = [];
                   process.elevatorProcessor.tempDown = [];
                   if united(1)<=process.currentFloor % elevator doesn't need to go up to carry the first request
                       process.downRequest = united;
                       process.direction = -1;
                   % if the elevator needs to go up to carry the first
                   % request, last situation we have dealt with it.
                   end
               else
                   % check the processor's tempUp request list...
                   % there shouldn't be any tempUp request that is higher
                   % than current floor.
                   if ~isempty(process.elevatorProcessor.tempUp)
                       ttt = process.elevatorProcessor.tempUp;
                       process.elevatorProcessor.tempUp = [];
                       if ttt(1) < process.currentFloor
                           process.direction = -1;
                           process.upRequest = ttt;
                       else
                           process.upRequest = ttt;
                       end
                   else
                       process.direction = 0;
                       process.t = dt;
                   end
               end
               process.calculateAndDisplay(dt);
           end
       end
       
       % elevator has "down" property (direction = -1)
       % a flip of upFunction...
       function downFunction(process,dt)
           if ~isempty(process.downRequest) % down request is not empty
               dist = process.h - process.downRequest(1)*process.floorHeight;
               if dist >=-0.02 && dist <= 0.02
                   process.a = 0;
                   process.v = 0;
                   process.ElevatorUI.openInsideDoor();
                   process.ElevatorUI.closeLight(process.currentFloor);
                   process.elevatorProcessor.openOutsideDoor(process.currentFloor,process.NO,-1);
                   process.door = 2;
                   process.t = dt;
                   process.downRequest(1) = [];
               elseif dist>0.02 && dist<1.01 && process.v <0
                   process.a = process.acceleration;
               else
                   if abs(process.v) >= process.speed && process.v <= process.speed+0.025
                       process.a = 0;
                   elseif abs(process.v) < process.speed
                       process.a = -process.acceleration;
                   end
               end
               process.calculateAndDisplay(dt);
               
           elseif ~isempty(process.upRequest) && process.upRequest(1) <= process.currentFloor
               dist = process.h - process.upRequest(1)*process.floorHeight ;
               if dist >=-0.02 && dist <= 0.02
                   process.direction = 1;
                   process.a = 0;
                   process.v = 0;
                   process.ElevatorUI.openInsideDoor();
                   process.ElevatorUI.closeLight(process.currentFloor);
                   process.elevatorProcessor.openOutsideDoor(process.currentFloor,process.NO,1);
                   process.door = 2;
                   process.t = dt;
                   process.upRequest(1) = [];
               elseif dist>0.02 && dist<1.01 && process.v <0
                   process.a = process.acceleration;
               else
                   if abs(process.v) >= process.speed && process.v <= process.speed+0.025
                       process.a = 0;
                   elseif abs(process.v) < process.speed
                       process.a = -process.acceleration;
                   end
               end
               process.calculateAndDisplay(dt);
                   
           else % elevator's down request is empty and the lowest up request is not lower than current
               % check total up requests
               united = unique([process.temp, process.elevatorProcessor.tempDown, process.downRequest]);
               if ~isempty(united)
                   process.temp = [];
                   process.elevatorProcessor.tempDown = [];
                   if united(1)>=process.currentFloor % elevator doesn't need to go down to carry the first request
                       process.upRequest = united;
                       process.direction = 1;
                   % if the elevator needs to go down to carry the first
                   % request, last situation we have dealt with it.
                   end
               else
                   % check the processor's tempDown request list...
                   % there shouldn't be any tempDown request that is lower
                   % than current floor.
                   if ~isempty(process.elevatorProcessor.tempDown)
                       ttt = process.elevatorProcessor.tempDown;
                       process.elevatorProcessor.tempDown = [];
                       if ttt(1) > process.currentFloor
                           process.direction = 1;
                           process.downRequest = ttt;
                       else
                           process.downRequest = ttt;
                       end
                   else
                       process.direction = 0;
                       process.t = dt;
                   end
               end
               process.calculateAndDisplay(dt);
           end
       end
       
       % used to set elevator's direction in stayFunciton().
       function setDir(process,aim,direction)
           if aim > process.currentFloor
               process.direction = 1;
           elseif aim < process.currentFloor
               process.direction = -1;
           else
               process.direction = direction;
           end
       end
       
       % elevator has "no direction" property (direction = 0)
       function stayFunction(process,dt)
           tup = unique([process.upRequest, process.elevatorProcessor.tempUp]);
           tdown = flip(unique([process.downRequest, process.elevatorProcessor.tempDown]));
           
           if ~isempty(tup)
               if ~isempty(tdown)
                   tupdir = tup(1)-process.currentFloor;
                   tdowndir = -1*(tdown(1)-process.currentFloor);
                   if tupdir*tdowndir > 0
                       if abs(tupdir) <= abs(tdowndir)
                           process.setDir(tup(1),1);
                           process.upRequest = tup;
                           process.elevatorProcessor.tempUp = [];
                       else 
                           process.setDir(tdown(1),-1);
                           process.downRequest = tdown;
                           process.elevatorProcessor.tempDown = [];
                       end
                   elseif tupdir*tdowndir < 0
                       if tupdir > 0
                           process.direction = 1;
                           process.upRequest = tup;
                           process.elevatorProcessor.tempUp = [];
                       else
                           process.direction = -1;
                           process.downRequest = tdown;
                           process.elevatorProcessor.tempDown = [];
                       end
                   else
                       if tupdir == 0
                           process.direction = 1;
                           process.upRequest = tup;
                           process.elevatorProcessor.tempUp = [];
                       else
                           process.direction = -1;
                           process.downRequest = tdown;
                           process.elevatorProcessor.tempDown = [];
                       end
                   end
               else
                   process.setDir(tup(1),1);
                   process.upRequest = tup;
                   process.elevatorProcessor.tempUp = [];
               end
               
           elseif ~isempty(tdown)
               process.setDir(tdown(1),-1);
               process.downRequest = tdown;
               process.elevatorProcessor.tempDown = [];
               
           else % all empty
               process.t = process.t + dt;
           end
           if process.t >= 120
               if process.currentFloor > process.defaultFloor
                   process.downRequest = 1;
                   process.t = 0;
               end
           
           end
           process.calculateAndDisplay(dt);
       end
       
   end
end