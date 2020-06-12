classdef chesstype
    %UNTITLED4 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        width;
        height;
        value;
        
    end
    
    methods
        function obj = chesstype(n)
            obj.value = n;
            if(n==4)
                obj.width = 200;
                obj.height = 200;
            elseif(n==2)
                obj.width = 100;
                obj.height = 200;
            elseif(n==1)
                obj.width = 100;
                obj.height = 100;
            end
        end

        
        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

