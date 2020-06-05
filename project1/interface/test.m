clear all
tic
a=0;
toc

s = [1,1,2,5,3];
iii = unique(s);
jjj = flip(iii);

function result=judgePos(process, elevatorNO, aim, dir)
    switch elevatorNO
        case 0
            edir = process.leftElevator.direction;
            efloor = process.leftElevator.currentFloor;
            ev = process.leftElevator.v;
            ea = process.leftElevator.acceleration;
            eh = process.leftElevator.h;
            
        case 1
            edir = process.rightElevator.direction;
            efloor = process.rightElevator.currentFloor;
            ev = process.rightElevator.v;
            ea = process.rightElevator.acceleration;
            eh = process.rightElevator.h;
            
    end
            if dir == 1
                if edir == dir && efloor < aim
                    tn = ev / ea;
                    s = ev * tn - 0.5 * ea * tn * tn;
                    if s < abs(eh-aim*process.floorHeight)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            elseif dir == -1
                if edir == dir && efloor > aim
                    tn = - ev / ea;
                    s = ev * tn + 0.5 * ea * tn * tn;
                    if abs(s) < abs(eh-aim*process.floorHeight)
                        result = true;
                    else
                        result = false;
                    end
                else
                    result = false;
                end
            end
        end
       