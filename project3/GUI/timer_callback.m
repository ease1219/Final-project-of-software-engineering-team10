classdef timer_callback
    properties
        app
        timer_id
    end


        function timer_init(app)
            app.Com_Timer_id = timer;
            app.Com_Timer_id.StartDelay = 0.0;
            app.Com_Timer_id.Period = 0.0;
            app.Com_Timer_id.ExecutionMode = 'fixedDelay';
            app.Com_Timer_id.TasksToExecute = 86400;
            app.Com_Timer_id.TimerFcn = @(~, ~) timer_handler(app);
        end
         %   x=1;

       
        function timer_start(app)
            start(app.Com_Timer_id);
        end
    
      
        function timer_stop(app)
            stop(app.Com_Timer_id);
        end
    
       
        function timer_delete(app)
            delete(app.Com_Timer_id);
        end
    

        function timer_handler(app)
            %
        end