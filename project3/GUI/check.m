classdef check
    properties
        
        physician
        patient
        t_min;
        baseline;
        bolus;
        limitDay;
        limitHour;
        used;
        left;
    end
    
    methods
        function [use,usedHour,usedDay,nameused]=checkbaseline(check,t_min,left,limitDay,limitHour,baseline,used)
            
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
                        
                    %判断这分钟打多少
                    if (usedHour_59min+baseline)>limitHour
                        
                            if (usedDay_23_baseline)>limitDay
                                used(k,j) = min(limitHour-usedHour_59min,limitDay-usedDay_23,left);
                                usedHour = used(k,j)+usedHour_59min;
                                usedDay = used(k,j)+usedDay_23;
                            else
                                used(k,j) = min(left,limitHour-usedHour_59min);
                                usedHour = used(k,j)+usedHour_59min;
                                usedDay = used(k,j)+usedDay_23;
                            end
                        
                    else
                        if (usedDay_23_baseline)>limitDay
                            used(k,j) = lim(left,limitDay-usedDay_23);
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
        
        function [usedHour,usedDay,nameused,YorN] = checkbolus(check,t_min,left,limitDay,limitHour,bolus,used)
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
                if (usedHour_59min+bolus)>limitHour
                    usedHour = usedHour_59min;
                    usedDay = usedDay_23;
                    YorN=0;
                else
                    if (usedDay_23_baseline)>limitDay
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