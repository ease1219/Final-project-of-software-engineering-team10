classdef elevatorProcessor < handle
    properties
        LeftElevatorApp     % UI
        RightElevatorApp    % UI
        BottomFloorApp      % UI
        TopFloorApp         % UI
        MiddleFloorApp      % UI
        leftElevator
        rightElevator
        tempUp = [];
        tempDown = [];
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
        
        function addUpRequest(process,aim)
           if not(any(process.tempUp==aim))
               process.tempUp = sort([process.upRequest,aim]);
           end
        end
       
        function addDownRequest(process,aim)
            if not(any(process.downRequest==aim))
                process.downRequest = sort([process.downRequest,aim],'descent');
            end
        end
        
        function judgeDist(process,floor)   % add the request to the nearest elevator
            if abs(process.leftElevator.currentFloor - floor) < abs(process.rightElevator.currentFloor - floor)
                process.leftElevator.receiveReq(process,floor);
            else
                process.rightElevator.receiveReq(process,floor);
            end
        end
        
        function receiveReq(process, floor, direction)
            if process.leftElevator.direction == 0 && process.rightElevator.direction == 0
                process.judgeDist(process,floor);
                
            elseif process.leftElevator.direction == 0 || process.rightElevator.direction == 0
                if process.leftElevator.direction == 0 
                    if process.leftElevator.currentFloor == floor
                        process.leftElevator.receiveReq(process,floor);
                    elseif process.rightElevator.direction == direction
                        process.rightElevator.receiveReq(process,floor);
                    else 
                        process.judgeDist(process,floor);
                    end
                    
                else
                    if process.rightElevator.currentFloor == floor
                        process.rightElevator.receiveReq(process,floor);
                    elseif process.leftElevator.direction == direction
                        process.leftElevator.receiveReq(process,floor);
                    else 
                        process.judgeDist(process,floor);
                    end
                end
            else 
                if process.leftElevator.direction == direction && process.rightElevator.direction == direction
                    process.judge(process,floor);
                elseif process.leftElevator.direction == direction 
                    process.leftElevator.receiveReq(process,floor);
                elseif process.rightElevator.direction == direction
                    process.rightElevator.receiveReq(process,floor);
                else
                    if direction
                end
            end
        end
    end
    
end