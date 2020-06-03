classdef elevatorProcessor < handle
    properties
        LeftElevatorApp     % UI
        RightElevatorApp    % UI
        FirstFloorApp       % UI
        SecondFloorApp      % UI
        ThirdFloorApp       % UI
        leftElevator
        rightElevator
        floorHeight = 3;    % for convenient, it'll be copied in elevator's properties.
        dt = 0.05;           % 1/dt defines the refresh rate of the processor.
        tempUp = [];
        tempDown = [];
    end
    
    methods
     
        function tempUpRequest(process,aim)
           process.tempUp = unique([process.tempUp,aim]);
        end
       
        function tempDownRequest(process,aim)
            mmm = unique([process.tempUp,aim]);
            process.tempDown = flip(mmm);
        end
        
        % judge the three problems:
        % 1.Is the direction wanted the same as the elevator's?
        % 2.Is the calling floor on the way of the elevator?
        % 3.Can the elevator stop at the calling floor in this single
        % running?
        % all three answers are OK, judgePos() will give TRUE.
        function result=judgePos(elevator,aim,dir)
            if dir == 1
                if elevator.direction == dir && elevator.currentFloor < aim
                    tn = elevator.v / elevator.acceleration;
                    s = elevator.v * tn - 0.5 * elevator.acceleration * tn * tn;
                    if s < abs(elevator.h-aim*elevator.floorHeight)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            elseif dir == -1
                if elevator.direction == dir && elevator.currentFloor > aim
                    tn = - elevator.v / elevator.acceleration;
                    s = elevator.v * tn + 0.5 * elevator.acceleration * tn * tn;
                    if abs(s) < abs(elevator.h-aim*elevator.floorHeight)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            end
        end
        
        % add the request to the nearest elevator
        function judgeDist(process,aim,direction)   
            leftDis = abs(process.leftElevator.h - aim*process.floorHeight);
            rightDis = abs(process.rightElevator.h - aim*process.floorHeight);
            if leftDis < rightDis
                process.leftElevator.receiveReq(aim,direction);
            else
                process.rightElevator.receiveReq(aim,direction);
            end
        end
        
        % add the request to the proper place
        function receiveReq(process, aim, direction)  
            % if both elevators are standing still, call the nearest
            % elevator
            if process.leftElevator.direction == 0 && process.rightElevator.direction == 0
                process.judgeDist(aim,direction);
            % if one is standing stll and another one is running
            elseif process.leftElevator.direction == 0 || process.rightElevator.direction == 0
                % left one is standing still
                if process.leftElevator.direction == 0 
                    % if the standing one is on the calling floor, use it
                    if process.leftElevator.currentFloor == aim
                        process.leftElevator.receiveReq(aim);
                    % or the request is on the running one's way and can be
                    % carried
                    elseif process.judgePos(process.rightElevator, aim, direction)
                        process.rightElevator.receiveReq(aim);
                    % neither, call the still one to carry
                    else 
                        process.leftElevator.receiveReq(aim);
                    end
                % right one still
                else
                    if process.rightElevator.currentFloor == aim
                        process.rightElevator.receiveReq(aim);
                    elseif process.judgePos(process.leftElevator, aim, direction)
                        process.leftElevator.receiveReq(aim);
                    else 
                        process.rightElevator.receiveReq(aim);
                    end
                end
            else  % both are running!
                % if left one is OK to carry
                if process.judgePos(process.leftElevator,aim,direction)
                    % while right one is OK too! this time call the nearest one
                    if process.judgePos(process.rightElevator,aim,direction)
                        process.judgeDist(aim,direction);
                    % right one is not OK...
                    else
                        process.leftElevator.receiveReq(aim);
                    end
                % if right one is OK to carry
                % since the situation of left is OK has been judged, just
                % let right one accept it
                elseif process.judgePos(process.rightElevator,aim,direction)
                    process.rightElevator.receiveReq(aim);
                % neither is OK to carry in their single run
                % store it in the processor's temporary list and wait
                else
                    if direction == 1
                        process.tempUpRequest(aim);
                    else
                        process.tempDownRequest(aim);
                    end
                end
            end
        end
        
        % open certain outside door by the elevator's info
        function openOutsideDoor(process, currentFloor, NO, direction)
            switch currentFloor
                case 1
                    switch NO
                        case 0
                            process.FirstFloorApp.openLeftDoor();
                            process.FirstFloorApp.Lamp.Color = [0.9,0.9,0.9];
                        case 1
                            process.FirstFloorApp.openRightDoor();
                            process.FirstFloorApp.Lamp.Color = [0.9,0.9,0.9];
                    end
                case 2
                    switch NO
                        case 0
                            process.SecondFloorApp.openLeftDoor();
                            switch direction
                                case 1
                                    process.SecondFloorApp.UpLamp.Color = [0.9,0.9,0.9];
                                case -1
                                    process.SecondFloorApp.DownLamp.Color = [0.9,0.9,0.9];
                            end
                        case 1
                            process.SecondFloorApp.openRightDoor();
                            switch direction
                                case 1
                                    process.SecondFloorApp.UpLamp.Color = [0.9,0.9,0.9];
                                case -1
                                    process.SecondFloorApp.DownLamp.Color = [0.9,0.9,0.9];
                            end
                    end
                case 3
                    switch NO
                        case 0
                            process.ThirdFloorApp.openLeftDoor();
                            process.ThirdFloorApp.Lamp.Color = [0.9,0.9,0.9];
                        case 1
                            process.ThirdFloorApp.openRightDoor();
                            process.ThirdFloorApp.Lamp.Color = [0.9,0.9,0.9];
                    end
            end
        end
        
        % close certain outside door by the elevator's info
        function closeOutsideDoor(process, currentFloor, NO)
            switch currentFloor
                case 1
                    switch NO
                        case 0
                            process.FirstFloorApp.closeLeftDoor();
                        case 1
                            process.FirstFloorApp.closeRightDoor();
                    end
                case 2
                    switch NO
                        case 0
                            process.SecondFloorApp.closeLeftDoor();
                        case 1
                            process.SecondFloorApp.closeRightDoor();
                    end
                case 3
                    switch NO
                        case 0
                            process.ThirdFloorApp.closeLeftDoor();
                        case 1
                            process.ThirdFloorApp.closeRightDoor();
                    end
            end
        end
        
        % display the information on each floor UI
        function displayInfo(process,NO,floorMessage,dirMessage)
            % left
            switch NO
                case 0
                    process.FirstFloorApp.displayLeftFloor(floorMessage);
                    process.SecondFloorApp.displayLeftFloor(floorMessage);
                    process.ThirdFloorApp.displayLeftFloor(floorMessage);
                    process.FirstFloorApp.displayLeftDir(dirMessage);
                    process.SecondFloorApp.displayLeftDir(dirMessage);
                    process.ThirdFloorApp.displayLeftDir(dirMessage);
                case 1
                    process.FirstFloorApp.displayRightFloor(floorMessage);
                    process.SecondFloorApp.displayRightFloor(floorMessage);
                    process.ThirdFloorApp.displayRightFloor(floorMessage);
                    process.FirstFloorApp.displayRightDir(dirMessage);
                    process.SecondFloorApp.displayRightDir(dirMessage);
                    process.ThirdFloorApp.displayRightDir(dirMessage);
            end
        end
        
        
    end
    
end