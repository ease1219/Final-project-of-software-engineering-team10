classdef singleElevator < handle
   properties
       speed = 1;               % the max speed of the elevator(m/s)
       acceleration = 0.5;      % the acceleration(m/s^2)
       v = 0;                   % real-time speed
       a = 0;                   % real-time acceleration
       h = 3;                   % real-time height, floor 1 is 3m high.
       direction = 0            % up(1) or down(-1), if no command, be zero
       currentFloor = 1;        % real-time, which floor the elevator is at.
       defaultFloor = 1;        % go to default floor after a period of time without running
       floorHeight              % height between two floor(m), will be copied from processor
       doorKeepTime = 5;        % after open the door, keep the door open for a short period of time(s)
       limitTime = 120          % time keep in the floor after finally usage before let it go to default floor(s)
       upRequest=[];            % used to store the requests of going up
       downRequest=[];          % used to store the requests of going down
       
       elevatorProcessor        % the processor
   end
   
   methods
       function addUpRequest(process,aim)
           if not(any(process.upRequest==aim))
               process.upRequest = sort([process.upRequest,aim]);
           end
       end
       
       function addDownRequest(process,aim)
           if not(any(process.downRequest==aim))
               process.downRequest = sort([process.downRequest,aim],'descent');
           end
       end
       
       function receiveReq(process,aim)
           if aim < process.currentFloor
               addDownRequest(aim);
           elseif aim > process.currentFloor
               addUpRequest(aim);
           end
       end
       
       function t0=speedUpTime(process,aim)
           distance = abs(process.currentFloor-aim) * process.floorHeight;
           t0 = sqrt(distance/process.acceleration);
           if t0 >= process.speed/process.acceleration
               t0 = process.speed/process.acceleration;
           end
       end
   end
end