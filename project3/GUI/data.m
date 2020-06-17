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
    function setname(name, name_n)
        switch name
            case 'name1'
                name1 = name_n;
                return name1;
            case 'name2'
                name2 = name_n;
                raturn namme2;
            case 'name3'
                name3 = name_n;
                return name3;
            case 'name4'
                name4 = name_n;
                return name4;
        end
    end
    function setnameused(name, nameused)
        switch name
            case 'name1'
                name1used = nameused;
                return name1used;
            case 'name2'
                name2used = nameused;
                return name2used;
            case 'name3'
                name3used = nameused;
                return name3used;
            case 'name4'
                name4used = nameused;
                return name4used;
        end
    end

end


end
