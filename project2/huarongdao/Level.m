classdef Level
    %UNTITLED4 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        name;
        positionlist;
    end
    
    methods
        function obj = Level(inputArg1)
            if(inputArg1 == 1)
                obj.name = "hdlm";
                obj.positionlist = [[1,3,4,0];[0,3,2,0];[3,3,2,0];[0,1,2,0];[3,1,2,0];[1,2,2,1];[0,0,1,0];[1,1,1,0];[2,1,1,0];[3,0,1,0]];
            elseif(inputArg1 == 2)
                obj.name = "hsjj";
                obj.positionlist = [[1,3,4,0];[0,3,2,0];[3,3,2,0];[0,1,2,0];[1,1,2,1];[1,2,2,1];[0,0,1,0];[3,1,1,0];[3,2,1,0];[3,0,1,0]];
            elseif(inputArg1 == 3)
                obj.name = "sjlf";
                obj.positionlist = [[0,3,4,0];[0,2,2,1];[2,2,2,1];[2,3,2,0];[3,3,2,0];[1,1,2,1];[0,0,1,0];[0,1,1,0];[3,1,1,0];[3,0,1,0]];
            elseif(inputArg1 == 4)
                obj.name = "sljb";
                obj.positionlist = [[1,3,4,0];[0,0,2,1];[3,3,2,0];[2,0,2,1];[0,1,2,1];[2,1,2,1];[0,2,1,0];[1,2,1,0];[2,2,1,0];[3,2,1,0]];
            elseif(inputArg1 == 5)
                obj.name = "test";
                obj.positionlist = [[1,1,4,0];[0,4,2,1];[2,4,2,1];[1,3,2,1];[0,2,2,0];[3,2,2,0];[0,0,1,0];[0,1,1,0];[3,0,1,0];[3,1,1,0]];
            end
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

