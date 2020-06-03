clear all
tic
a=0;
toc

s = [1,1,2,5,3];
iii = unique(s);
jjj = flip(iii);

function downFunction(process,dt)
           if ~isempty(process.downRequest) % up request is not empty
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
               elseif dist>0.02 && dist<1.01
                   process.a = process.acceleration;
               else
                   if process.v >= -(process.speed+0.02) && process.v <= -(process.speed-0.02) && process.a ~= 0
                       process.a = 0;
                   elseif abs(process.v) < process.speed-0.02
                       process.a = -process.acceleration;
                   end
               end
               process.calculateAndDisplay(dt);
               
           elseif ~isempty(process.upRequest) && process.upRequest(1)*process.floorHeight <= process.h
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
               elseif dist>0.02 && dist<1.01 
                   process.a = process.acceleration;
               else
                   if process.v >= -(process.speed+0.02) && process.v <= -(process.speed-0.02) && process.a ~= 0
                       process.a = 0;
                   elseif abs(process.v) < process.speed -0.02
                       process.a = -process.acceleration;
                   end
               end
               process.calculateAndDisplay(dt);
                   
           else % elevator's down request is empty and the lowest up request is not lower than current
               % check total up requests
               united = flip(unique([process.temp, process.elevatorProcessor.tempDown, process.downRequest]));
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
       