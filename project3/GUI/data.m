% baseline, bolus, usedday, usedhr,left
classdef data
    properties
        name
    end
    methods
    function name_n = getname(name)
        switch name
            case 'name1'
                name1=[0.01,0.2,0.0,0.0,20];
                name_n = name1;
            case 'name2'
                name2=[0.01,0.2,0.0,0.0,20];
                name_n = name2;
            case 'name3'
                name3=[0.01,0.2,0.0,0.0,20];
                name_n = name3;
            case 'name4'
                name4=[0.01,0.2,0.0,0.0,20];
                name_n = name4;
        end
    end 
        function nameused = getnameused(name)
        switch name
            case 'name1'
                name1used=zeros(24,60);
                nameused = name1used;
            case 'name2'
                name2used=zeros(24,60);
                nameused = name2used;
            case 'name3'
                name3used=zeros(24,60);
                nameused = name3used;
            case 'name4'
                name4used=zeros(24,60);
                nameused = name4used;
        end
    end 
    


end


end
