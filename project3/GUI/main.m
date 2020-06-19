
close all
clear all
physicianAPP=physician;
patientAPP=patient;
patientAPP.physician = physicianAPP;

namelist = ['name1','name2','name3','name4'];

% 4 patient
patient1 = singlePatient;
patient1.name = namelist(1);
patient1.used = zeros(24,60);
patient1.datalist = [0.01,0.2,0.0,0.0,20]; %baseline, bolus, usedday, usedhr, left
patient2 = singlePatient;
patient2.name = namelist(2);
patient2.used = zeros(24,60);
patient2.datalist = [0.03,0.3,0.0,0.0,20]; 
patient3 = singlePatient;
patient3.name = namelist(3);
patient3.used = zeros(24,60);
patient3.datalist = [0.05,0.4,0.0,0.0,20]; 
patient4 = singlePatient;
patient4.name = namelist(4);
patient4.used = zeros(24,60);
patient4.datalist = [0.06,0.2,0.0,0.0,20]; 
%patientlist = [patient1,patient2,patient3,patient4];



t=0;

tt = timer;
tt.StartDelay = 0;
tt.ExecutionMode = 'fixedRate';
tt.Period = 1;
tt.TasksToExecute = inf;
tt.TimerFcn = @(~,~)running(patient1,patient2,patient3,patient4,t,patientAPP);

start(tt);


function running(patient1,patient2,patient3,patient4,t,patientAPP)
    t = t+1;
    patientAPP.t=t;
    if t==1441
        t=0;
    end
        physicianAPP.patient1datalist = patient1.datalist;
        physicianAPP.patient1name = patient1.name;
        physicianAPP.patient1used = patient1.used;
        physicianAPP.patient2datalist = patient2.datalist;
        physicianAPP.patient2name = patient2.name;
        physicianAPP.patient2used = patient2.used;
        physicianAPP.patient3datalist = patient3.datalist;
        physicianAPP.patient3name = patient3.name;
        physicianAPP.patient3used = patient3.used;
        physicianAPP.patient4datalist = patient4.datalist;
        physicianAPP.patient4name = patient4.name;
        physicianAPP.patient4used = patient4.used;
    
    for i=1:4
        baseline(t);
    end
        patient1.datalist = physicianAPP.patient1datalist;
        patient1.name = physicianAPP.patient1name;
        patient1.used = physicianAPP.patient1used;
        patient2.datalist = physicianAPP.patient2datalist;
        patient2.name = physicianAPP.patient2name;
        patient2.used = physicianAPP.patient2used;
        patient3.datalist = physicianAPP.patient3datalist;
        patient3.name = physicianAPP.patient3name;
        patient3.used = physicianAPP.patient3used;
        patient4.datalist = physicianAPP.patient4datalist;
        patient4.name = physicianAPP.patient4name;
        patient4.used = physicianAPP.patient4used;
end



function baseline(t)
    for i = 1:length(patientlist)
        patient = patientlist(i);
        checkbaseline(physicianAPP,t,patient);
        physicianAPP.reflect(patient);
    end
end