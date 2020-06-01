classdef elevatorProcessor < handle
    properties
        LeftElevatorApp     % UI
        RightElevatorApp    % UI
        BottomFloorApp      % UI
        TopFloorApp         % UI
        MiddleFloorApp      % UI
        leftElevator
        rightElevator
        floorHeight = 3;    % for convenient, it'll be copied in elevator's properties.
        tempUp = [];
        tempDown = [];
    end
    
    methods
     
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
        
        % judge the three problems:
        % 1.Is the direction wanted the same as the elevator's?
        % 2.Is the calling floor on the way of the elevator?
        % 3.Can the elevator stop at the calling floor in this single
        % running?
        % all three answers are OK, judgePos() will give TRUE.
        function result=judgePos(elevator,floor,dir)
            if dir == 1
                if elevator.direction == dir && elevator.currentFloor < floor
                    tn = elevator.v / elevator.acceleration;
                    s = elevator.v * tn - 0.5 * elevator.acceleration * tn * tn;
                    if s < abs(elevator.h-floor*elevator.floorHeight)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            elseif dir == -1
                if elevator.direction == dir && elevator.currentFloor > floor
                    tn = - elevator.v / elevator.acceleration;
                    s = elevator.v * tn + 0.5 * elevator.acceleration * tn * tn;
                    if abs(s) < abs(elevator.h-floor*elevator.floorHeight)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            end
        end
        
        function judgeDist(process,floor)   % add the request to the nearest elevator
            leftDis = abs(process.leftElevator.h - floor*process.floorHeight);
            rightDis = abs(process.rightElevator.h - floor*process.floorHeight);
            if abs(process.leftElevator.currentFloor - floor) < abs(process.rightElevator.currentFloor - floor)
                process.leftElevator.receiveReq(floor);
            else
                process.rightElevator.receiveReq(floor);
            end
        end
        
        function receiveReq(process, floor, direction)  % add the request to the proper place
            % if both elevators are standing still, call the nearest
            % elevator
            if process.leftElevator.direction == 0 && process.rightElevator.direction == 0
                process.judgeDist(floor);
            % if one is standing stll and another one is running
            elseif process.leftElevator.direction == 0 || process.rightElevator.direction == 0
                % left one is standing still
                if process.leftElevator.direction == 0 
                    % if the standing one is on the calling floor, use it
                    if process.leftElevator.currentFloor == floor
                        process.leftElevator.receiveReq(floor);
                    % or the request is on the running one's way and can be
                    % carried
                    elseif process.rightElevator.direction == direction
                        process.rightElevator.receiveReq(floor);
                    % neither, call the nearest elevator
                    else 
                        process.judgeDist(floor);
                    end
                % right one
                else
                    if process.rightElevator.currentFloor == floor
                        process.rightElevator.receiveReq(floor);
                    elseif process.leftElevator.direction == direction
                        process.leftElevator.receiveReq(floor);
                    else 
                        process.judgeDist(floor);
                    end
                end
            else  % both are running!
                % if left one is OK to carry
                if process.judgePos(process.leftElevator,floor,direction)
                    % while right one is OK too! 
                    % this time call the nearest one
                    if process.judgePos(process.rightElevator,floor,direction)
                        process.judgeDist(floor);
                    % right one is not OK...
                    else
                        process.leftElevator.receiveReq(floor);
                    end
                % if right one is OK to carry...
                % since the situation of left is OK has been judged, just
                % let right one accept it
                elseif process.judgePos(process.rightElevator,floor,direction)
                    process.rightElevator.receiveReq(floor);
                % neither is OK to carry in this single run...
                % store it in the processor's temporary list and wait
                else
                    if direction == 1
                        process.addUpRequest(floor);
                    else
                        process.addDownRequest(floor);
                    end
                end
            end
        end
        
        
    end
    
end