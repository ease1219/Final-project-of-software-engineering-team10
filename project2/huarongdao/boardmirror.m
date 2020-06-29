classdef boardmirror
    %UNTITLED6 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        mirror = [11 11 11 11 11 14 11;11 0 0 0 0 0 11;11 0 0 0 0 0 11;11 0 0 0 0 0 11;11 0 0 0 0 0 11;11 11 11 11 11 11 11];
    end
    
    methods
        function obj = boardmirror(level)
            for i=1:10
                if(level.positionlist(i,3) == 4)
                    obj.mirror(level.positionlist(i,1)+2,6-level.positionlist(i,2)) = i;
                    obj.mirror(level.positionlist(i,1)+3,6-level.positionlist(i,2)) = i;
                    obj.mirror(level.positionlist(i,1)+2,5-level.positionlist(i,2)) = i;
                    obj.mirror(level.positionlist(i,1)+3,5-level.positionlist(i,2)) = i;
                elseif(level.positionlist(i,3) == 2&&level.positionlist(i,4)==1)
                    obj.mirror(level.positionlist(i,1)+2,6-level.positionlist(i,2)) = i;
                    obj.mirror(level.positionlist(i,1)+3,6-level.positionlist(i,2)) = i;
                elseif(level.positionlist(i,3) == 2&&level.positionlist(i,4)==0)
                    obj.mirror(level.positionlist(i,1)+2,6-level.positionlist(i,2)) = i;
                    obj.mirror(level.positionlist(i,1)+2,5-level.positionlist(i,2)) = i;
                elseif(level.positionlist(i,3) == 1)
                    obj.mirror(level.positionlist(i,1)+2,6-level.positionlist(i,2)) = i;
                end
            end
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

