classdef singleElevator < handle
   properties
       speed            % the max speed of the elevator
       acceleration     % the acceleration
       direction=0      % up(1) or down(-1), if no command, be zero
       currentFloor = 1;% simply, which floor the elevator is at. Initially at 1.
       defaultFloor = 1;
       doorKeepTime     % after open the door, keep the door open for a short period of time
       limitTime        % time keep in the floor after finally usage before let it go to default floor
       upRequest=[];        % used to store the requests of going up
       downRequest=[];      % used to store the requests of going down
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
               addDownRequest(process,aim);
           elseif aim > process.currentFloor
               addUpRequest(process,aim);
           else
               
           end
       end
   end
end