
close all
clear all
physicianAPP=physician;
patientAPP=patient;
check;
patientAPP.name1 = physicianAPP.name1; 
patientAPP.name1used = physicianAPP.name1used;
patientAPP.name2 = physicianAPP.name2; 
patientAPP.name2used = physicianAPP.name2used;
patientAPP.name3 = physicianAPP.name3; 
patientAPP.name3used = physicianAPP.name3used;
patientAPP.name4 = physicianAPP.name4; 
patientAPP.name4used = physicianAPP.name4used;

tt = timer;
tt.StartDelay = 0;
tt.ExecutionMode = 'fixedRate';
tt.Period = 60;
tt.TasksToExecute = inf;
%tt.TimerFcn = @(~,~);

physicianAPP.Timer = timer('TimerFcn','@(~,~)app1.timerstart(app1);', 'Period', 1, 'ExecutionMode', 'fixedDelay', 'TasksToExecute',1441);
%app1.Timer.TimerFcn = app1.timerstart(app1);
start(physicianAPP.Timer);
patientAPP.t=physicianAPP.t;








 