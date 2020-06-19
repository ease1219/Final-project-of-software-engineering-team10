
close all
clear all
physicianAPP=physician;

namelist = ["name1","name2","name3","name4"];

% 4 patient
patient1 = singlePatient;
patient1.PhysicianUI = physicianAPP;
patient1.name = namelist(1);
patient1.baseline = 0.01;
patient1.bolus = 0.2;
patient2 = singlePatient;
patient2.PhysicianUI = physicianAPP;
patient2.name = namelist(2);
patient2.baseline = 0.03;
patient2.bolus = 0.3;
patient3 = singlePatient;
patient3.PhysicianUI = physicianAPP;
patient3.name = namelist(3);
patient3.baseline = 0.05;
patient3.bolus = 0.4;
patient4 = singlePatient;
patient4.PhysicianUI = physicianAPP;
patient4.name = namelist(4);
patient4.baseline = 0.06;
patient4.bolus = 0.2;

physicianAPP.patient1 = patient1;
physicianAPP.patient2 = patient2;
physicianAPP.patient3 = patient3;
physicianAPP.patient4 = patient4;
physicianAPP.chosenPatient = patient1;
physicianAPP.TextArea.Value = "name1";
P1APP = patient;
P2APP = patient;
P3APP = patient;
P4APP = patient;

P1APP.physician = physicianAPP;
P1APP.patientp = patient1;
P1APP.Label.Text = "name1";
P2APP.physician = physicianAPP;
P2APP.patientp = patient2;
P2APP.Label.Text = "name2";
P3APP.physician = physicianAPP;
P3APP.patientp = patient3;
P3APP.Label.Text = "name3";
P4APP.physician = physicianAPP;
P4APP.patientp = patient4;
P4APP.Label.Text = "name4";

t = 0;

tt = timer;
tt.StartDelay = 0;
tt.ExecutionMode = 'fixedRate';
tt.Period = 1;
tt.TasksToExecute = inf;
tt.TimerFcn = @(~,~)running(P1APP,P2APP,P3APP,P4APP,patient1,patient2,patient3,patient4,physicianAPP);

start(tt);


function running(P1APP,P2APP,P3APP,P4APP,patient1,patient2,patient3,patient4,physicianAPP)
    
    t = P1APP.t;
    t = t+1;
    
    if t==1441
        t=0;
    end
    
    P1APP.t=t;
    P2APP.t=t;
    P3APP.t=t;
    P4APP.t=t;

    patient1.checkbaseline(t);
    patient2.checkbaseline(t);
    patient3.checkbaseline(t);
    patient4.checkbaseline(t);
    
    switch physicianAPP.chosenPatient.name
        case "name1"
            physicianAPP.reflect(patient1.baseline,patient1.bolus,patient1.usedDay,patient1.usedHour,patient1.left);
        case "name2"
            physicianAPP.reflect(patient2.baseline,patient2.bolus,patient2.usedDay,patient2.usedHour,patient2.left);
        case "name3"
            physicianAPP.reflect(patient3.baseline,patient3.bolus,patient3.usedDay,patient3.usedHour,patient3.left);
        case "name4"
            physicianAPP.reflect(patient4.baseline,patient4.bolus,patient4.usedDay,patient4.usedHour,patient4.left);
    end


end
