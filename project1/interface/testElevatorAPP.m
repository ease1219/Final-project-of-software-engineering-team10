classdef testElevatorAPP < matlab.uitest.TestCase
    properties
        
    end
    
    methods(testMethodSetup)
        function launchAPP(testCase) 
            testCase.elevator1APP = Elevator_UI;
            testCase.elevator2APP = Elevator_UI;
            LE = singleElevator;
            RE = singleElevator;
            EP = singleElevator;
            
        end
    end
end