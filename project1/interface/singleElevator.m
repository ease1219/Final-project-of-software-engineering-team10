classdef singleElevator < handle
   properties
       speed            % the max speed of the elevator
       acceleration     % the acceleration
       direction        % up(1) or down(-1)
       currentFloor     % simply, which floor the elevator is at.
       defaultFloor = 1;
       doorKeepTime     % after open the door, keep the door open for a short period of time
       limitTime        % time keep in the floor after finally usage before let it go to default floor
   end
   
   methods
       
   end
end