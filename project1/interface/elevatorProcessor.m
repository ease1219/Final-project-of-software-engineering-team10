classdef elevatorProcessor < handle
    properties
        ElevatorApp
        FloorApp
        leftElevator
        rightElevator
    end
    
    methods
        function createLeftElevator(process, speed, acceleration, doorkeeptime, limittime)
            left = singleElevator;
            left.speed = speed;
            left.acceleration = acceleration;
            left.doorkeeptime = doorkeeptime;
            left.limittime = limittime;
            process.leftElevator = left;
        end
        
        function createRightElevator(process, speed, acceleration, doorkeeptime, limittime)
            right = singleElevator;
            right.speed = speed;
            right.acceleration = acceleration;
            right.doorkeeptime = doorkeeptime;
            right.limittime = limittime;
            process.rightElevator = right;
        end
        
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