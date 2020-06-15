app1=physician;
app2=patient;


        app1.name1baseline = 0.01; app1.name1bolus = 0.2; app1.name1used1= 0.0; app1.name1used2= 0.0;app1.name1left= 20;
        app1.name2baseline = 0.01; app1.name2bolus = 0.2; app1.name2used1= 0.0; app1.name2used2= 0.0;app1.name2left= 20;
        app1.name3baseline = 0.01; app1.name3bolus = 0.2; app1.name3used1= 0.0; app1.name3used2= 0.0;app1.name3left= 20;
        app1.name4baseline = 0.01; app1.name4bolus = 0.2; app1.name4used1= 0.0; app1.name4used2= 0.0;app1.name4left= 20;
   
        timer_init(app1);
        timer_init(app2);
 function startupFcn(app)
       timer_init(app);
 end
