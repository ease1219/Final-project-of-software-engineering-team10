
close all
clear all
app1=physician;
app2=patient;
check;
app2.name1 = app1.name1; 
app2.name1used = app1.name1used;
app2.name2 = app1.name2; 
app2.name2used = app1.name2used;
app2.name3 = app1.name3; 
app2.name3used = app1.name3used;
app2.name4 = app1.name4; 
app2.name4used = app1.name4used;

app1.Timer = timer('TimerFcn','@(~,~)app1.timerstart(app1);', 'Period', 1, 'ExecutionMode', 'fixedDelay', 'TasksToExecute',1441);
%app1.Timer.TimerFcn = app1.timerstart(app1);
start(app1.Timer);
app2.t=app1.t;








 