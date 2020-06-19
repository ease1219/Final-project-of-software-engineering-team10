classdef singlePatient < handle
    properties
        name
        baseline
        bolus
        usedDay = 0;
        usedHour = 0;
        left = 20;
        
        used = zeros(24,60);        % table storing 24*60min used data
        use_now                     % current min used 
        limitHour=1;
        limitDay=3;
        
        PhysicianUI                 % UI
    end
    
    methods
        function checkbaseline(process,t)  
            k = fix(t/24+1);
            j = mod(t,24)+1;
            %前23小时59分用掉了多少
            usedDay_23 = sum(process.used(:))-process.used(k,j);
            %前59分钟用掉了多少
            if k==1
                last_k = 24;
            else
                last_k=k-1;
            end
            usedHour_59min = sum(process.used(k,:))+sum(process.used(last_k,:));
            for m=1:j
                usedHour_59min = usedHour_59min-process.used(last_k,m);
            end
            for m = j:60
                usedHour_59min = usedHour_59min-process.used(k,m);
            end
                        
                    %判断这分钟打多少
            % if add baseline, the used painkiller will be over limit of
            % hour
            if (usedHour_59min+process.baseline)>process.limitHour

                process.used(k,j) = 0;
                process.usedHour = process.used(k,j)+usedHour_59min;
                process.usedDay = process.used(k,j)+usedDay_23;
            else
                % judge the limit of day
                if (usedDay_23)>process.limitDay
                    process.used(k,j) = 0;
                    process.usedHour = process.used(k,j)+usedHour_59min;
                    process.usedDay = process.used(k,j)+usedDay_23;
                else
                    process.used(k,j) = min(process.left,process.baseline);
                    process.usedHour = usedHour_59min+process.used(k,j);
                    process.usedDay = usedDay_23+process.used(k,j);
                end
            end
            n = process.used(k,j);
            process.use_now = n;
            process.left = process.left - process.used(k,j);
        end
        
        function YorN=checkbolus(process,t)
            k = fix(t/24+1);
            j = mod(t,24)+1;

            %前23小时59分用掉了多少
            usedDay_23 = sum(process.used(:))-process.used(k,j);
            %前59分钟用掉了多少
            if k==1
                last_k = 24;
            else
                last_k=k-1;
            end
            usedHour_59min = sum(process.used(k,:))+sum(process.used(last_k,:));
            for m=1:j
                usedHour_59min = usedHour_59min-process.used(last_k,m);
            end
            for m = j:60
                usedHour_59min = usedHour_59min-process.used(k,m);
            end
                      
                %判断打不打
            if process.left<process.bolus
                YorN = 0;
            end
            if (usedHour_59min+process.bolus)>process.limitHour
                process.usedHour = usedHour_59min;
                process.usedDay = usedDay_23;
                YorN = 0;
            else
                if (usedDay_23)>process.limitDay
                    process.usedHour = usedHour_59min;
                    process.usedDay = usedDay_23;
                    YorN=0;
                else
                    process.used(k,j) = process.used(k,j)+process.bolus;
                    process.usedHour = usedHour_59min+process.bolus;
                    process.usedDay = usedDay_23+process.bolus;
                    YorN=1;
                end
            end
            process.left = process.left - process.used(k,j);
        end
    end
end