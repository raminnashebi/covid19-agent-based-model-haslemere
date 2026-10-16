
%% Calculzting basic reproduction number 

for k=1:9 % 9 different  transmission rates
  for j=1:500 % j is number of simulation 
         
         Ancestor(:,2)=Total_Ancestor1{j,k}{1,2};% descendants matrix of agents  
                                              
         Ancestor(:,1)=1:size(Ancestor(:,1),1);
         Ancestor(:,3)=State_counter1{j,k}{1,2};% inserting State of each agent into 
                                                % descendants matrix of agents
         L=find(Ancestor(:,3)==5);% we choose agents with hospitalized (5) state 
         
         % Among the agents with hospitalize stage we out those agents
         % which we initializ our seconde simulation with them.
         if length(L)>0
         L1=find(init_exp1{j,k}{1,1}(:,1)==4);
         L2=find(init_exp1{j,k}{1,1}(:,1)==3);
         
         L4=ismember(L,init_exp1{j,k}{1,1}(L1,2),'rows');
         L5=ismember(L,init_exp1{j,k}{1,1}(L2,2),'rows');
         L6=logical(L5+L4);
         if length(L6)>0
         L(L6)=[];
         end
        
         end
         
        if length(L)>0
          for i=1:size(L,1)
              R0_counter(i)=sum(Ancestor(:,2)==Ancestor(L(i),1));% Counting the descendants of a discovered agent 
                                                                 
                                                               
          end
         else
              R0_counter=[];
        end
        if length(R0_counter)>0
              R0{j,k}=mean(R0_counter,2);% store averaged descendants of a discovered agents 
                                         % for each 9 different transmission rates and 500 simulations
                                         
        else
              R0{j,k}=0;
        end
     L=[];
     Ancestor=[];
     R0_counter=[];
     
   end
end



for k=1:9
    for j=1:500
        R0_final(j,k)=R0{j,k};% basic reproduction number for each 9 different transmission rates and 500 simulations
    end
end
   
 for k=1:9
        for j=1:500
        TV_r(j,k)=Totalcase1{j,k}{1,2}(end,1);% total cases for each 9 different transmission rates and 500 simulations
       
        end
 end
 %}
 for i=1:9
     for j=1:500
 Problar1_OH1(j,i)=Problar1_OH{j,i}; % Effective-outside transmission probability for each 9 
                                     % different transmission rates and 500 simulations
     end
 end
 
 
 
 







