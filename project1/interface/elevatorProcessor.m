classdef elevatorProcessor < handle
    properties
        LeftElevatorApp     % UI
        RightElevatorApp    % UI
        BottomFloorApp      % UI
        TopFloorApp         % UI
        MiddleFloorApp      % UI
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
        
        function receiveReq(process, floor, direction)
            
        end
    end
    
end