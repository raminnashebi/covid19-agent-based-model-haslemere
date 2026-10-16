function [state,counter] = StateUpdate_V0(state,counter,counterlimit0,counterlimit1,counterlimit3,counterlimit4,a)
% this function used to update the state of each individual after each time

if (state~=(2))&&(state~=(5))&&(state~=(-1))% State matrix store individuals infection stage 
               % '2' recovered 
               % '5' hospitalized
               % '-1' susceptible
               
    if state==(0) % if individual is in exposed stage
        if counter>=counterlimit0 % current number of time which passed is bigger than
                                  % equal to mean number of days in exposed
                                  % stage
            if rand()<((1)-a)
                % proceed to Undocumented
                state=(1);
                counter=(0);
            else
                %proceed to Pre semptomatik
                state=(3);
                counter=(0);
            end
        else
            
            counter=counter+(1);% increase amount of time that passed
        end

    elseif state==(1)% if individual is in asymptomatic stage
        
        if counter>=counterlimit1 % current number of time which passed is bigger than
                                  % equal to mean number of days in asymptomatic
                                  % stage

            state=(2); % proceed to recovered stage
            counter=(0); 
        else

            counter=counter+(1);
        end  
    elseif state==(3)% if individual is in presyptomatic stage
        if counter>=counterlimit3 % current number of time which passed is bigger than
                                  % equal to mean number of days in presymptomatic
                                  % stage
            state=(4);% proceed to symptomatic stage
            counter=(0);
        else
            counter=counter+(1);
        end
    elseif state==(4)% if individual is in symptomatic stage
        if counter>=counterlimit4 % current number of time which passed is bigger than
                                  % equal to mean number of days in presymptomatic
                                  % stage
            state=(5);% proceed to hospitalized stage
            
            counter=(0);
        else
            counter=counter+(1);
        end
   
   end
    


end

