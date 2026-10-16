

M=csvread('Kissler_DataS1.csv');% Halsemere dataset
M(M(:,4)>20,:)=[];% Deleting interaction which occured more than 20 meters distance

load('FNM_HOME_5m+20m_time_symmetry'); % Household contact network
load('FNM_WORK_5m+20m_time_symmetry'); % Workplace contact network
load('FNM_OUTDOOR_5m+20m_time_symmetry') % Social environment contact network


% Entering inputs for main_EK_v_RN agent based model simulator

granularity=16*12;  % parameter that indicate number of 5 minute interaction in
                    % one day of Halsemer dataset
a1=0.9841; % Scaling parameters of distance, which we use it to calculate 
           % infectiouse probability   
Transmission_rate1=0.1672*ones(1,9);% Transmission rate inside household 
Transmission_rate2=[0.001,0.005,0.01,0.02,0.03,0.04,0.05,0.1,0.1672]; % Transmission rate outside household (workplace and social environment)

le=2.7; % mean number of days in the latency stage
la=5.4;% mean number of days in the asymptomatic stage
lp=2.4;% mean number of days in pre-symptomatic stage
ls=3;% mean number of days in symptomatic stage

    R0_exact=2.87;% COVID-19 exact basic reproduction number
    SAR_exact=0.46;% COVID-19 exact household secandary attack rate
for w=1
    a1=rand();% random Scaling parameters of distance, which we use it to calculate infectiouse probability     
    b1=rand();% random Transmission rate inside household 
    b2=b1; % Transmission rate outside household (workplace and social environment)
    



    

parfor i=1:500% starting simulation for 500 times
  
    [tem1,tem2,tem3,tem4,tem5,tem6,tem7,tem8]= agent_based_simulator(M,granularity,le,la,lp,ls,a1,b1,b2);
    TotalVaka{i}=tem1; % totalcase after 14 day simulation 
    Total_Ancestor1{i}=tem2;% descendants matrix of a discovered agent 
    Total_Ancestor2{i}=tem3;% Give chain of infection matrix by storing ancestor and descendants of each agent 
    State_counter{i}=tem4;% Give matrix of state of each indiviual at the end of 14 day simulation.
    init_exp1{i}=tem5;% Give matrix of exposed individual which we restrate  simulation after the first 14 days  warmup run
    PROB{i}=tem6;% Give matrix of infectiouse probability for each interaction 
    PROB_OH{i}=tem7;% Give matrix of infectiouse probability nonhousehold(workplace, social environment)
    PROB_IH{i}=tem8;% Give matrix of infectiouse probability household
end


% Calculating basic reproduction number with random parameters

for k=1
  for j=1:1
         
         Ancestor(:,2)=Total_Ancestor1{j,k}{1,2};
         
         Ancestor(:,1)=1:size(Ancestor(:,1),1);
         Ancestor(:,3)=State_counter{j,k}{1,2};
         L=find(Ancestor(:,3)==5);
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
              R0_counter(i)=sum(Ancestor(:,2)==Ancestor(L(i),1));
          end
         else
              R0_counter=[];
        end
        if length(R0_counter)>0
              R0{j,k}=mean(R0_counter,2);
        else
              R0{j,k}=0;
        end
     L=[];
     Ancestor=[];
    
     R0_counter=[];
         
   end
end

for k=1
    for j=1
        R0_final(j,k)=R0{j,k};
    end
end
    R0_final(isnan(R0_final))=0;
    R0_M=mean(R0_final);
   
Ancestor=[];

% Calculating Secondary attack rate with random parameters

   for k=1:1:500
for j=1:1:500
      Ancestor(:,2)=Total_Ancestor1{j,k}{1,2};% descendants matrix of agents  
         Ancestor(:,1)=1:size(Ancestor(:,1),1);
         Ancestor(:,3)=State_counter{j,k}{1,2};% inserting State of each agent into 
                                               % descendants matrix of agents
    
    
target1=Ancestor(find(Ancestor(:,2)==-1),:);% Descendants matrix, agents which are exposed 
target2=Ancestor(find(Ancestor(:,2)~=-1),:);% Descendants matrix, agents which are not exposed  
target2(end+1:2*end,1)=target2(1:end,2);
target2((end/2)+1:end,2)=target2(1:end/2,1);
target2(:,3)=[];

% Identifying  contact of 10 agents (we initializ our first round of simulation 
% with these 10 agent) which occured in housheold
n1=2;m=1;
for n=1:size(target1,1)
a=find(FNM_Home(:,1)==target1(n,1));
if size(a,1)~=0
ini_10(1:size(a,1),m:n1)=FNM_Home(a,:);
end
m=m+2;n1=n1+2;
end
if size(ini_10,1)~=0
ini_10(:,find(ini_10(1,:)==0))=[];
total_H_num=size(ini_10,2)/2;% Total number contact matrix of those agents which 10 initial exposed agents 


% Finding hosuehold infectiouse interaction of 10 initial exaposed individuals with

n1=2;m=1;
for g=1:size(ini_10,2)/2
    
H1=ini_10(:,m:n1);
H1(find(H1(:,1)==0),:)=[];
H1_total_num(1,g)=size(H1,1)+1;
H1_sus_num(1,g)=size(H1,1);
h1=ismember(H1,target2,'rows');
H1_inf_num(1,g)=sum(h1)+1;% 
m=m+2;n1=n1+2;
end

% Calcultating household secondary attact rate (SAR)
SAR(j,k)=(sum(H1_inf_num)-total_H_num)/(sum(H1_total_num)-total_H_num); 
end
target1=[];
target2=[];
ini_10=[];
H1_total_num=[];
H1_sus_num=[];
H1_inf_num=[];

end
end
  SAR_M=mean(SAR);    

 Sampling_result(w,[1 2 3 4])=[a1 b1 R0_M SAR_M];% storing sampling for each random parameters
 y1(w,1)=abs(R0_exact-R0_M);% Error between exact COVID-19 basic reproduction number (R0_eaxct) and sample one (R0_M)
 y2(w,1)=abs(SAR_exact- SAR_M);% Error between exact COVID-19 household secondary attact rate (SAR_exact) and sample one (SAR_M)
 
 R0_M=[];
 SAR_M=[];
 R0_counter=[];
 R0_counter_home=[];
 Ancestor=[];
 target1=[];
 target2=[];
 ini_10=[];
 H1_total_num=[];
 H1_sus_num=[];
 H1_inf_num=[];
end


