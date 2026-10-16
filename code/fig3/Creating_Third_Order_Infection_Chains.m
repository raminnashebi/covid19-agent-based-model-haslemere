%% Creating Third Order Infection Chains

% Required matrix : Total_Ancestor2
% Desription about Total_Ancestor2 matrix: There is 469 row. The number of rows indicates agents. 
%                                          Each column gives the ancestor and descendant of agents. 
%                                          if the first and second  column of an agent is -1, that  
%                                          agent is our simulation initializer. if the last column
%                                          of each row is finished with -1,it means the first order (2
%                                          agents) second order (3 agents)and third order (4 agents)
%                                          infections chains are ended
%          

load('FNM_HOME_5m+20m_symmetry');% Household contact network
load('FNM_Outside_Home_5m+20m_symmetry');% non-household (workplace, social environment) contact network

w=1;
w1=3;

for v=1:9 % 9 different transmission rates
for i=1:500 % number of simulation 

%     
Ancestor3(:,1:size(Total_Ancestor2{i,v}{1,2},2))=Total_Ancestor2{i,v}{1,2};% choosing second round simulation outputs
                                                                          % from Total_ancestor2 matrix    
% Arranging Ancestor3 matrix 

if size(Ancestor3,2)>1

Ancestor3(:,size(Ancestor3,2)+1)=1:469;
Ancestor3(:,size(Ancestor3,2)+1)=State_counter{i,v}{1,2}(:,1);
k=find(Ancestor3(:,size(Ancestor3,2))==-1);
Ancestor3(k,:)=[];
Ancestor3(:,size(Ancestor3,2))=[];
Ancestor3(:,1)=[];
k1=find(Ancestor3(:,1)==-1);
Ancestor3(k1,:)=[];
k2=find(Ancestor3(:,1)==0);
Ancestor3(k2,:)=[];

if size(Ancestor3,1)>0
for j=1:size(Ancestor3,1)
        x=find(Ancestor3(j,:)==-1);
        if size(x,2)>0
        Ancestor3(j,x)=Ancestor3(j,end);
        Ancestor3(j,x+1:end)=0;
        end
end

for j=1:size(Ancestor3,1)
if Ancestor3(j,end-1)==0 && Ancestor3(j,end)>0
  Ancestor3(j,end-1)=Ancestor3(j,end);
  Ancestor3(j,end)=0;
end
end

   if size(Ancestor3,2)>2
for j=1:size(Ancestor3,1)
if Ancestor3(j,end-2)==0 && Ancestor3(j,end-1)>0
  Ancestor3(j,end-2)=Ancestor3(j,end-1);
  Ancestor3(j,end-1)=0;
end
end
   end
   
for j=1:size(Ancestor3,1)
    s1=ismember(Ancestor3(:,:),Ancestor3(j,:),'rows');
if sum(s1)>1
    Ancestor3(j,:)=0;
end
end


for j=1:size(Ancestor3,1)
    s1=ismember(Ancestor3(:,1:end-1),Ancestor3(j,1:end-1),'rows');
if sum(s1)>1
    if Ancestor3(j,end)==0
      Ancestor3(j,:)=0;
    end
end
end

x3=find(Ancestor3(:,1)==0);
Ancestor3(x3,:)=[];


for j=1:size(Ancestor3,1)
    s1=ismember(Ancestor3(:,1:end-2),Ancestor3(j,1:end-2),'rows');
if sum(s1)>1
    if Ancestor3(j,end-1)==0
      Ancestor3(j,:)=0;
    end
end
end
x3=find(Ancestor3(:,1)==0);
Ancestor3(x3,:)=[];% Final form of Ancestor and decendant of agent after rearranging
                   % in here 

% Identification of the environment (household, work, social) of contacts in the chain of infection

k=0;
p=0;
Ancestor4=[];% storing environment (household, work, social) of contacts in the chain of infection
for q1=1:size(Ancestor3,1)
    for q2=1:size(Ancestor3,2)-1
        
  x(1,1)=Ancestor3(q1,q2);
  x(1,2)=Ancestor3(q1,q2+1);
    y1=ismember(x,FNM_Home,'rows');
    y2=ismember(x,FNM_outside_home,'rows');
    if y1==1
        Ancestor4(q1,q2)=1; % Hosuehold conact in chain of infection
        k=k+1;
    elseif y2==1
        Ancestor4(q1,q2)=2;% Non-household (workplace, social environment) in chain of infection
        p=p+1;
    end
    x=[];
    end
end

   
if size(Ancestor4,2)==1
    Ancestor4(:,[2 3 4])=0;
elseif size(Ancestor4,2)==2
    Ancestor4(:,[3 4])=0;
elseif  size(Ancestor4,2)==3
     Ancestor4(:,4)=0;
end


x3=find(Ancestor4(:,1)==0);
Ancestor4(x3,:)=[];


% Choosing only third order (4 agents) infection chains and store it in
% "Ancestor4_tripple" matrix

z=1;
if size(Ancestor4,2)>=3
for g1=1:size(Ancestor4,1)
    g3=find(Ancestor4(g1,:)>0);
    if size(g3,2)==3
        Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
    elseif size(g3,2)==4
        Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
     elseif size(g3,2)==5   
         Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,3:5);
        z=z+1;
        elseif size(g3,2)==6   
         Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,3:5);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,4:6);
        z=z+1;
        elseif size(g3,2)==7   
         Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,3:5);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,4:6);
        z=z+1;
         Ancestor4_tripple(z,:)=Ancestor4(g1,5:7);
        z=z+1;
        elseif size(g3,2)==8   
         Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,3:5);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,4:6);
        z=z+1;
         Ancestor4_tripple(z,:)=Ancestor4(g1,5:7);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,6:8);
        z=z+1;
        elseif size(g3,2)==9   
         Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,3:5);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,4:6);
        z=z+1;
         Ancestor4_tripple(z,:)=Ancestor4(g1,5:7);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,6:8);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,7:9);
        z=z+1;
        elseif size(g3,2)==10   
         Ancestor4_tripple(z,:)=Ancestor4(g1,1:3);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,2:4);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,3:5);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,4:6);
        z=z+1;
         Ancestor4_tripple(z,:)=Ancestor4(g1,5:7);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,6:8);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,7:9);
        z=z+1;
        Ancestor4_tripple(z,:)=Ancestor4(g1,8:10);
        z=z+1;
    end
end
end
        


y=[1 1 1; 1 1 2 ; 1 2 1 ; 1 2 2 ; 2 1 1 ; 2 1 2 ; 2 2 1 ; 2 2 2 ];% All combination of third order of infection chain
                                                                  % where 1 is for household 2 is for non-household
% Calculating occurence ratio of each third order infetion chain                                                                  
if size(Ancestor4_tripple,1)>0
for h=1:8
ydata=ismember(Ancestor4_tripple(:,:),y(h,:),'rows');
ydata_num(h,i)=sum(ydata);
ydata_ratio(h,i)=(ydata_num(h,i))/size(Ancestor4_tripple,1);% third order infetion chains occurence ratio
end
else
    ydata_ratio(1:8,i)=0;
end

end
end

w=w+3;
w1=w1+3;
Ancestor3=[];
Ancestor4=[];

end
end

ratio_total=sum(ydata_ratio);
E1=find(ratio_total==0);
ydata_num(:,E1)=[];
ydata_ratio(:,E1)=[];


