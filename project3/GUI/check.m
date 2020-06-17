classdef check
    properties
        
        physicianAPP
        patientAPP
        t_min;
        limitDay = 3;
        limitHour = 1;
        used;
        left;
    end
    
    methods
        function [use,usedHour,usedDay,nameused]=checkbaseline(process,t_min,left,used)
            
            k = fix(t_min/24+1);
            j = mod(t_min,24);
            
                    %前23小时59分用掉了多少
            usedDay_23 = sum(used(:))-used(k,j);
                    %前59分钟用掉了多少
            if k==1
                last_k = 24;
            else
                last_k=k-1;
            end
            usedHour_59min = sum(used(k,:))+sum(used(last_k,:));
            if j~=1
                for m=1:j-1
                    usedHour_59min = usedHour_59min-used(last_k,m);
                end
            end
                    for m = j:60
                        usedHour_59min = usedHour_59min-used(k,m);
                    end
                        
                    %判断这分钟打多少
                    if (usedHour_59min+baseline)>process.limitHour

                        used(k,j) = 0;
                        usedHour = used(k,j)+usedHour_59min;
                        usedDay = used(k,j)+usedDay_23;
                        
                    else
                        if (usedDay_23_baseline)>process.limitDay
                            used(k,j) = 0;
                            usedHour = used(k,j)+usedHour_59min;
                            usedDay = used(k,j)+usedDay_23;
                        else
                            used(k,j) = min(left,baseline);
                            usedHour = usedHour_59min+used(k,j);
                            usedDay = usedDay_23+used(k,j);
                        end
                    end
                    nameused=used;
                    use = used(k,j);
                %end
            %end
        end
        
        function [usedHour,usedDay,nameused,YorN] = checkbolus(process,t_min,left,bolus,used)
            k = fix(t_min/24+1);
            j = mod(t_min,24);
            %for k=1:24
             %   for j = 1:60
                    %前23小时59分用掉了多少
                    usedDay_23 = sum(used(:))-used(k,j);
                    %前59分钟用掉了多少
                    if k==1
                        last_k = 24;
                    else
                        last_k=k-1;
                    end
                    usedHour_59min = sum(used(k,:))+sum(used(last_k,:));
                    if j~=1
                        for m=1:j-1
                            usedHour_59min = usedHour_59min-used(last_k,m);
                        end
                    end
                    for m = j:60
                        usedHour_59min = usedHour_59min-used(k,m);
                    end
                      
                %判断打不打
                if left<bolus
                    YorN = 0;
                end
                if (usedHour_59min+bolus)>process.limitHour
                    usedHour = usedHour_59min;
                    usedDay = usedDay_23;
                    YorN=0;
                else
                    if (usedDay_23_baseline)>process.limitDay
                        usedHour = usedHour_59min;
                        usedDay = usedDay_23;
                        YorN=0;
                    else
                        used(k,j) = used(k,j)+bolus;
                        usedHour = usedHour_59min+bolus;
                        usedDay = usedDay_23+bolus;
                        YorN=1;
                    end
                end
                nameused=used;
        end
    end
end