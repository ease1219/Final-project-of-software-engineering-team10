classdef ChessPosition
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        caocaop;
        machaop;
        huangzhongp;
        zhangfeip;
        guanyup;
        zhaoyunp;
        zu1p;
        zu2p;
        zu3p;
        zu4p;
        name;
    end
    
    methods
        function obj = ChessPosition(list)
            obj.caocaop = list.positionlist(1,:);
            obj.machaop = list.positionlist(2,:);
            obj.huangzhongp = list.positionlist(3,:);
            obj.zhangfeip = list.positionlist(4,:);
            obj.guanyup = list.positionlist(5,:);
            obj.zhaoyunp = list.positionlist(6,:);
            obj.zu1p = list.positionlist(7,:);
            obj.zu2p = list.positionlist(8,:);
            obj.zu3p = list.positionlist(9,:);
            obj.zu4p = list.positionlist(10,:);
            obj.name = "hdlm";
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

