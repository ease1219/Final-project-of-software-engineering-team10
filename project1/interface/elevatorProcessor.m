classdef elevatorProcessor < handle
    properties
        leftElevator
        rightElevator
    end
    
    methods
        function El = chooseElevator(process, direction, currentFloor)
           El = 0; % 0 means choose the left elevator, 1 means choose the right elevator 
           if process.leftElevator.currentFloor == currentFloor
               El = 0;
           elseif process.rightElevator.currentFloor == currentFloor
               El = 1;
           else
               if direction == 1  % here 1 means go up, -1 means go down
                   
               end
                   
           end
        end
    end
    
end