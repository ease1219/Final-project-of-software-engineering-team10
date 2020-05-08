classdef singleElevator < handle
   properties
       speed
       acceleration
       currentFloor
       defaultFloor = 1;
       doorKeepTime % after open the door, keep the door open for a short period of time
       stayTime % time keep in the floor after finally usage before let it go to default floor
   end
   
   methods
       
   end
end