   
M=csvread('Kissler_DataS1.csv');% Halsemere dataset
M(M(:,4)>20,:)=[];% Deleting interaction which occured more than 20 meters distance


load('FNM_HOME_5m+20m_time_symmetry'); % Household contact network
load('FNM_WORK_5m+20m_time_symmetry'); % Workplace contact network
load('FNM_OUTDOOR_5m+20m_time_symmetry') % Social environment contact network

% Entering inputs for agent based model simulator (agent_based_simulator.m)


granularity=16*12; % parameter that indicate number of 5 minute interaction in
                    % one day of Halsemer dataset 
a1=0.9841;  % Scaling parameters of distance, which we use it to calculate 
           % infectiouse probability   
Transmission_rate1=0.1672*ones(1,9);% Transmission rate inside household 
Transmission_rate2=[0.001,0.005,0.01,0.02,0.03,0.04,0.05,0.1,0.1672];% Transmission rate outside household (workplace and social environment)

le=2.7; % mean number of days in the latency stage
la=5.4;% mean number of days in the asymptomatic stage
lp=2.4;% mean number of days in pre-symptomatic stage
ls=3;% mean number of days in symptomatic stage



for j=1:length(Transmission_rate1)
   b1=Transmission_rate1(j);
   b2=Transmission_rate2(j);


    

for i=1:500 % starting simulation for 500 times
    
    [tem1,tem2,tem3,tem4,tem5,tem6,tem7,tem8]= agent_based_simulator(M,granularity,le,la,lp,ls,a1,b1,b2);
    TotalVaka{i,j}=tem1;% totalcase after 14 day simulation 
    Total_Ancestor1{i,j}=tem2;% descendants matrix of a discovered agent 
    Total_Ancestor2{i,j}=tem3;% Give chain of infection matrix by storing ancestor and descendants of each agent 
    State_counter{i,j}=tem4;% Give matrix of state of each indiviual at the end of 14 day simulation.
    INIT_EXP{i,j}=tem5;% Give matrix of exposed individual which we restrate  simulation after the first 14 days  warmup run
    PROB{i,j}=tem6;% Give matrix of infectiouse probability for each interaction 
    PROB_OH{i,j}=tem7;% Give matrix of infectiouse probability nonhousehold(workplace, social environment)
    PROB_IH{i,j}=tem8;% Give matrix of infectiouse probability household
end
end

TV_WR{1,1}=TotalVaka;
TA_WR1{1,1}=Total_Ancestor1;
TA_WR2{1,1}=Total_Ancestor2;
SC_WR{1,1}=State_counter;
INI_EXP_WR{1,1}=INIT_EXP;
Prob{1,1}=PROB;
Prob_OH{1,1}=PROB_OH;
Prob_IH{1,1}=PROB_IH;




Total_Ancestor1=[];
Total_Ancestor2=[];
Total_Ancestor3=[];
Total_Ancestor4=[];
Total_Ancestor5=[];
Total_Ancestor6=[];

State_counter1=[];
State_counter2=[];
State_counter3=[];
State_counter4=[];
State_counter5=[];
State_counter6=[];

Totalcase1=[];
Totalcase2=[];
Totalcase3=[];
Totalcase4=[];
Totalcase5=[];
Totalcase6=[];

Problar1=[];
Problar2=[];
Problar3=[];
Problar4=[];
Problar5=[];
Problar6=[];

Problar1_OH=[];
Problar2_OH=[];
Problar3_OH=[];
Problar4_OH=[];
Problar5_OH=[];
Problar6_OH=[];

Problar1_IH=[];
Problar2_IH=[];
Problar3_IH=[];
Problar4_IH=[];
Problar5_IH=[];
Problar6_IH=[];

init_exp1=[];
init_exp2=[];
init_exp3=[];
init_exp4=[];
init_exp5=[];
init_exp6=[];


Total_Ancestor1=TA_WR1{1,1};
State_counter1=SC_WR{1,1};
Totalcase1=TV_WR{1,1};
Problar1=Prob{1,1};
Problar1_OH=Prob_OH{1,1};
Problar1_IH=Prob_IH{1,1};
init_exp1=INI_EXP_WR{1,1};

