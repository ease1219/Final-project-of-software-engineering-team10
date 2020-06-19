classdef singlePatient
    properties
        name
        used
        datalist
        
        use_now
        usedHour=1;
        usedDay=3;
        YorN=0;
    end
    
    methods
        function checkbaseline(process,t,patient)  
            k = fix(t/24+1);
            j = mod(t,24);
            patient.use_now=patient.used(k,j);

                    %前23小时59分用掉了多少
            usedDay_23 = sum(patient.used(:))-patient.used(k,j);
                    %前59分钟用掉了多少
            if k==1
                last_k = 24;
            else
                last_k=k-1;
            end
            usedHour_59min = sum(patient.used(k,:))+sum(patient.used(last_k,:));
            if j~=1
                for m=1:j-1
                    usedHour_59min = usedHour_59min-patient.used(last_k,m);
                end
            end
                    for m = j:60
                        usedHour_59min = usedHour_59min-patient.used(k,m);
                    end
                        
                    %判断这分钟打多少
                    if (usedHour_59min+patient.datalist)>process.limitHour

                        patient.used(k,j) = 0;
                        patient.usedHour = patient.used(k,j)+usedHour_59min;
                        patient.usedDay = patient.used(k,j)+usedDay_23;
                    else
                        if (usedDay_23_baseline)>process.limitDay
                            patient.used(k,j) = 0;
                            patient.usedHour = patient.used(k,j)+usedHour_59min;
                            patient.usedDay = patient.used(k,j)+usedDay_23;
                        else
                            patient.used(k,j) = min(patient.datalist(5),patient.datalist);
                            patient.usedHour = usedHour_59min+patient.used(k,j);
                            patient.usedDay = usedDay_23+patient.used(k,j);
                        end
                    end
                    patient.use_now = patient.used(k,j);
        end
        
        function checkbolus(process,t,patient)
            k = fix(t/24+1);
            j = mod(t,24);
            patient.use_now=patient.used(k,j);
            %for k=1:24
             %   for j = 1:60
                    %前23小时59分用掉了多少
                    usedDay_23 = sum(patient.used(:))-patient.used(k,j);
                    %前59分钟用掉了多少
                    if k==1
                        last_k = 24;
                    else
                        last_k=k-1;
                    end
                    usedHour_59min = sum(patient.used(k,:))+sum(patient.used(last_k,:));
                    if j~=1
                        for m=1:j-1
                            usedHour_59min = usedHour_59min-patient.used(last_k,m);
                        end
                    end
                    for m = j:60
                        usedHour_59min = usedHour_59min-patient.used(k,m);
                    end
                      
                %判断打不打
                if patient.datalist(5)<patient.datalist(2)
                    patient.YorN = 0;
                end
                if (usedHour_59min+patient.datalist(2))>process.limitHour
                    patient.usedHour = usedHour_59min;
                    patient.usedDay = usedDay_23;
                    patient.YorN=0;
                else
                    if (usedDay_23_baseline)>process.limitDay
                        patient.usedHour = usedHour_59min;
                        patient.usedDay = usedDay_23;
                        patient.YorN=0;
                    else
                        patient.used(k,j) = patient.used(k,j)+patient.datalist(2);
                        patient.usedHour = usedHour_59min+patient.datalist(2);
                        patient.usedDay = usedDay_23+patient.datalist(2);
                        patient.YorN=1;
                    end
                end
        end
    end
end