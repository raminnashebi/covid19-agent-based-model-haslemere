function [TotalVaka,Total_Ancestor1,Total_Ancestor2,State_counter,init_exp,Problar1,Problar1_OH1,Problar1_IH1]=agent_based_simulator(M,granularity,le,la,lp,ls,a1,b1,b2)
% Agent based model simulator  

% Purpose
% Simulate  course of COVID-19 disease over Halsemere dataset. for doing
% this our simulator fist import real contact network. after that it expant
% three day contact network to 14 day contact network. 
%
% Inputs 
% M           - Contact network Matrix of 469 people in three consecutive day
%               (Halsemere dataset). The numbers from 1 up to 469
%               demonstrate each individual
% granularity - parameter that indicate number of 5 minute interaction in
%               one day of Halsemer dataset
% le          - mean number of days in the latency stage
% la          - mean number of days in the asymptomatic stage
% lp          - mean number of days in pre-symptomatic stage
% ls          - mean number of days in symptomatic stage
% al          - Scaling parameters of distance, which we use it to calculate 
%               infectiouse probability
% b1          - Transmission rate inside household 
% b2          - Transmission rate outside household (workplace and socila
%               environment )
%
% Outputs 
% TotalVaka       - Give vector of totalcases for each 5 minutus  
% Total_Ancestor1 - Give descendants matrix of a discovered agent 
% Total_Ancestor2 - Give chain of infection matrix by storing ancestor and
%                   descendants of each agent
% State_counter   - Give matrix of state of each indiviual at the end of 14
%                   day simulation. '-1' show susceptible state, '0' for
%                   exposed, '1' for asymptomatic, '2' recovered, '3' presymptomatic,
%                   '4' symptomatic, and '5' hospitalized.
% init_exp        - Give matrix of exposed individual which we restrate 
%                   simulation after the first 14 days  warmup run
% Problar1        - Give matrix of infectiouse probability for each 
%                   interaction which occured in eaxh 5 minutes time 
%                   interval during 3 consecutive day. The method for 
%                   calculating infectious probability given in method and
%                   material part of paper 
% Problar1_OH1    - Give matrix of infectiouse probability nonhousehold
%                   (workplace, social environment)
% Problar1_IH1    - Give matrix of infectiouse probability household


%% For random contact network (optional)
%{ 
for i=1:41099
    x=randi(469,1);
    y=randi(469,1);
    M(i,[2 3])=[x y];
end

for i=1:41099
  if M(i,2)==M(i,3)
      M(i,2)=randi(469,1);
  end
end
%}

%%
% Creating contact network for interaction which occured on Thursday
% (persembe)
x1=find(M(:,1)==192);
persembe=M(1:x1(end),:);

% Creating contact network for interaction which occured on Friday (cuma)
x2=find(M(:,1)==384);
cuma=M(x1(end)+1:x2(end),:);

% Creating contact network for interaction which occured on Saturday 
%(weekend)
weekend=M(x2(end)+1:end,:);

%%

s1=randi(2,1,5);% Generate 5 random number from 1 (Thursday) and 2 (Friday)
MM=[];% store new 14 day expanded contact network where Weekday contacts are 
      % taken from Thursday (persembe), Friday (cuma) from Halsemere
      % dataset randomly. The weekend contacts are replicated from Saturday 
      % contacts of the Haslemere data 

s7=1;

for s2=1:5
    c1=size(MM,1);
if s1(s2)==1
    if s2==1
    MM(1:size(persembe,1),:)=persembe;%sets MM to thursday
    else
         MM(c1+1:size(persembe,1)+c1,:)=persembe;
    end
    
else 
    if s2==1
    MM(1:size(cuma,1),:)=cuma;  %sets MM to friday
    else
         MM(c1+1:size(cuma,1)+c1,:)=cuma;
    end
    
end

% 
if MM(end,1)==384
    s4=0;
for s5=193:384
   s6=find(MM(c1+1:size(MM,1),1)==s5);
   MMM(s6+c1,1)=s7+s4;
   s4=s4+1;
   s6=[];
end
MMM(c1+1:size(MM,1),2:4)=MM(c1+1:size(MM,1),2:end);
else
    s4=0;
for s5=1:192
   s6=find(MM(c1+1:size(MM,1),1)==s5);
   MMM(s6+c1,1)=s7+s4;
   s4=s4+1;
   s6=[];
end
MMM(c1+1:size(MM,1),2:4)=MM(c1+1:size(MM,1),2:end);
end
s7=s7+192;

end
s8=size(MMM,1);
MMM(s8+1:15413+s8,2:4)=weekend(:,2:4);

s9=0;
for s10=385:576
   s11=find(weekend(1:size(weekend,1),1)==s10);
   MMMM(s11,1)=961+s9;
   s9=s9+1;
   s11=[];
end
MMM(s8+1:size(MMM,1),1)=MMMM(:,1);

s8=size(MMM,1);
MMM(s8+1:15413+s8,2:4)=weekend(:,2:4);

s9=0;
for s10=385:576
   s11=find(weekend(1:size(weekend,1),1)==s10);
   MMMM(s11,1)=1153+s9;
   s9=s9+1;
   s11=[];
end
MMM(s8+1:size(MMM,1),1)=MMMM(:,1);

Mnew1=MMM;% Our 1 week of 14 day expanded contact network

MM=[];
MMM=[];
MMMM=[];


x1=find(M(:,1)==192);
persembe=M(1:x1(end),:);

x2=find(M(:,1)==384);
cuma=M(x1(end)+1:x2(end),:);

weekend=M(x2(end)+1:end,:);

s1=randi(2,1,5);
MM=[];
s7=1345;

for s2=1:5
    c1=size(MM,1);
if s1(s2)==1
    if s2==1
    MM(1:size(persembe,1),:)=persembe;
    else
         MM(c1+1:size(persembe,1)+c1,:)=persembe;
    end
    
else 
    if s2==1
    MM(1:size(cuma,1),:)=cuma;
    else
         MM(c1+1:size(cuma,1)+c1,:)=cuma;
    end
    
end

if MM(end,1)==384
    s4=0;
for s5=193:384
   s6=find(MM(c1+1:size(MM,1),1)==s5);
   MMM(s6+c1,1)=s7+s4;
   s4=s4+1;
   s6=[];
end
MMM(c1+1:size(MM,1),2:4)=MM(c1+1:size(MM,1),2:end);
else
    s4=0;
for s5=1:192
   s6=find(MM(c1+1:size(MM,1),1)==s5);
   MMM(s6+c1,1)=s7+s4;
   s4=s4+1;
   s6=[];
end
MMM(c1+1:size(MM,1),2:4)=MM(c1+1:size(MM,1),2:end);
end
s7=s7+192;

end
s8=size(MMM,1);
MMM(s8+1:15413+s8,2:4)=weekend(:,2:4);

s9=0;
for s10=385:576
   s11=find(weekend(1:size(weekend,1),1)==s10);
   MMMM(s11,1)=2305+s9;
   s9=s9+1;
   s11=[];
end
MMM(s8+1:size(MMM,1),1)=MMMM(:,1);

s8=size(MMM,1);
MMM(s8+1:15413+s8,2:4)=weekend(:,2:4);

s9=0;
for s10=385:576
   s11=find(weekend(1:size(weekend,1),1)==s10);
   MMMM(s11,1)=2497+s9;
   s9=s9+1;
   s11=[];
end
MMM(s8+1:size(MMM,1),1)=MMMM(:,1);

Mnew2=MMM;% Our 2 week of 14 day expanded contact network

M(1:size(Mnew1,1),:)=Mnew1;
M(size(Mnew1,1)+1:size(Mnew2,1)+size(Mnew1,1),:)=Mnew2; % Our 14 day expanded contact network 
%%
% Apply stay-at-home restriction  (optitional)

load('FNM_HOME_5m+20m_time_symmetry'); % loading Household contacat netwoeks
load('FNM_WORK_5m+20m_time_symmetry');% loading workplace contacat netwoeks
load('FNM_OUTDOOR_5m+20m_time_symmetry')% loading nonhousehold contacat netwoeks

for i=1:2688 % i indicate the 5 minutes time interval which in total there
             % is 2688 in our 14 day contact network
 
 % In here we apply stay-at-home restriction on Thursdat of first week by
 % changing nonhousehold contacts with household contacts (Optional)
        if i>576 & i<769
  t=mod(i,384);
  if t==0
      t=384;
  end
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end       
       
 % In here we apply stay-at-home restriction on Friday of first week by
 % changing nonhousehold contacts with household contacts  (Optional)
 
       if i>768 & i<961
  t=mod(i,576);
  if t==0
      t=384;
  end
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
       end       
  
% In here we apply stay-at-home restriction on Saturday of first week by
 % changing nonhousehold contacts with household contacts (Optional)
 
  if i>960 & i<1153
  t=mod(i,576);
  if t==0
      t=576;
  end
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end      
   
 % In here we apply stay-at-home restriction on Sunday of first week by
 % changing nonhousehold contacts with household contacts (Optional)
 
if i>1152 & i<1345
  t=mod(i,576)+384;
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end
x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end

% In here we apply stay-at-home restriction on Thursday of second week by
 % changing nonhousehold contacts with household contacts (Optional)
 
if i>1920 & i<2113
  t=mod(i,576);
  if t==0
      t=384;
  end
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end

% In here we apply stay-at-home restriction on Friday of second week by
 % changing nonhousehold contacts with household contacts (Optional)
 
if i>2112 & i<2305
  t=mod(i,384);
  if t==0
      t=384;
  end
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end

% In here we apply stay-at-home restriction on Saturday of second week by
 % changing nonhousehold contacts with household contacts (Optional)
 
if i>2304 & i<2497
  t=mod(i,576)+384;
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end
 
% In here we apply stay-at-home restriction on Sunday of second week by
 % changing nonhousehold contacts with household contacts (Optional)
 
if i>2496 & i<2689
  t=mod(i-1344,576)+384;
  x=find(M(:,1)==i);
   Xwork=find(FNM_Work_time(:,1)==t);
    Xhome=find(FNM_Home_time(:,1)==t);
     Xoutdoor=find(FNM_Outdoor_time(:,1)==t);
     MW=FNM_Work_time(Xwork,:);
     MH=FNM_Home_time(Xhome,:);
     MO=FNM_Outdoor_time(Xoutdoor,:);
     
     
    L1=ismember(M(x,[2 3]),FNM_Work_time(:,[2 3]),'rows');
     L2=ismember(M(x,[2 3]),FNM_Home_time(:,[2 3]),'rows');
       L3=ismember(M(x,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows');
       if sum(L1)>0
        M(x(L1),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L1),1),1),[2 3 4]);
       end
       if sum(L3)>0
        M(x(L3),[2 3 4])=MH(randi(size(FNM_Home_time(Xhome,:),1),size(x(L3),1),1),[2 3 4]);
       end 
        x=[];
L1=[];
L2=[];
L3=[];
Xwork=[];
Xhome=[];
Xoutdoor=[];
MW=[];
MO=[];
MH=[];
end
end
    
M(end+1:2*size(M,1),[1,2,3,4])=M(:,[1,3,2,4]);% Altered contact network 
   [M,~]=sortrows(M,1); 
%%
   
% In here we calculate the infection probability for each household and non-household interaction separately.

POP=(max(max(M(:,[2 3]))));% Maximum population 
N=POP;

d=M(:,4);

load('FNM_HOME_5m+20m_symmetry'); % importing household contact network
for j=1:length(b2)
   
for i=1:size(d,1)
 k=ismember(M(i,[2 3]),FNM_Home,'rows');
  if k==1
  Problar(i,j)=b1(j)*exp(-a1*(d(i)));% calculating infection probability of ith interation 
                                     % with b1(j) transmission probability
                                     % for household
                                     
   else
       Problar(i,j)=b2(j)*exp(-a1*(d(i)));% calculating infection probability of ith interation 
                                     % with b1(j) transmission probability
                                     % for nonhousehold (social
                                     % environment, workplace)
   end   
  
end
end

load('FNM_Outside_Home_5m+20m_symmetry');% loading non-household contacat netwoeks
load('FNM_HOME_5m+20m_symmetry');% loading non-household contacat netwoeks

O1=ismember(M(:,[2 3]),FNM_outside_home,'rows');
H1=ismember(M(:,[2 3]),FNM_Home,'rows');
Problar1_OH=Problar(O1,:);% non-household (social environmet, workplace) infection probability
Problar1_IH=Problar(H1,:);% Household infection probability
%%

a=0.83*ones(POP,1); % The ratio of symptomatic cases

% We have our 14 day conact network now we can start simulation  

for  sim_NO=1:2 % we start two simulation, the first one is warm up simulation 
                %  for 14 day the second simulation start with two exposed individual
                % which take from first simulation
ws=1;

if sim_NO==1 
    
    
    State=((-1*ones(POP,1)));   
    TR=randi(length(State),10,1); % choosing 10 individual randomly to start our first round simulations
    State(unique(TR))=0; % change state of these 10 individual to exposed
    counter=((zeros(POP,1)));% count the number of time that passed from state of each individual

    counterlimit0=(((ones(POP,1).*(le*granularity)))); % mean number of days in the exposed stage 
    counterlimit1=(((ones(POP,1).*(la*granularity))));% mean number of days in the asymptomatic stage 
    counterlimit3=(((ones(POP,1).*((lp)*granularity))));% mean number of days in the presymptomatic stage 
    counterlimit4=(((ones(POP,1).*((ls)*granularity))));% mean number of days in the symptomatic stage 
    

   % Initializing vectors which are necessary for catching ancestor and descendant of infectious individual  
    
    Time_Ancestor1=zeros(POP,1);
    Ancestor1=zeros(POP,1); % This matrix store the ancestor of each individual 
    Ancestor2=zeros(POP,1); % this matrix  store the chain of infection 
    Sira=zeros(POP,1);
    Ancestor1(TR,1)=-1;
    Ancestor2(TR,1)=-1;
    Sira(TR)=1;

else
    
    
    
   

    counterlimit0=(((ones(POP,1).*(le*granularity))));
    counterlimit1=(((ones(POP,1).*(la*granularity))));
    counterlimit3=(((ones(POP,1).*((lp)*granularity))));
    counterlimit4=(((ones(POP,1).*((ls)*granularity))));
    
    
    
    Time_Ancestor1=zeros(POP,1);
    Ancestor1=zeros(POP,1);
    Ancestor2=zeros(POP,1);
    Sira=zeros(POP,1);
    Ancestor1(TR4(:,2),1)=-1;
    Ancestor2(TR4(:,2),1)=-1;
    Sira(TR4(:,2))=1;

end


 
 
 
 if sim_NO==1 
    
 i=1;
 z=1;
  
 
 % In here we infect individuals which contact with infectious individual with respect to 
 % their infectiouse probability 
 
 while i<2689
      
  while M(z,1)==i
        M1=M(z,2); % M1 individual which is connect with M2 individual at i 5min time interval
                   % in z row of M contact network
        M2=M(z,3);% M2 individual which is connect with M1 individual at i 5min time interval
                  % in z row of M contact network
        A=State(M1); % state of M1 individual at i time interval   
        B=State(M2); % state of M1 individual at i time interval    
        
        if A==-1 && (B==1)  % infecting individual which is contact with asymptomatic individual
           
            load('FNM_HOME_5m+20m_symmetry');
            w=ismember([M1 M2],FNM_Home,'rows');
            
             if w==1
                 % Transmission reduction fator for asymptomatic cases inside household
                  if rand()<0.696*Problar(z)
                     State(M1)=0; % M1 individula became exposed 
                     Ancestor1(M1,1)=M2; % M2 individual is ancestor of M1 individual 
                     Time_Ancestor1(M1,1)=i; 
                  end
             else 
                 % Transmission reduction fator for asymptomatic cases outside household
                   if rand()<0.42*Problar(z)
                      State(M1)=0;
                      Ancestor1(M1,1)=M2;
                      Time_Ancestor1(M1,1)=i;
                   end
             end
                  % making infection chain  
                  Ancestor2(M1,1:Sira(M2))=Ancestor2(M2,1:Sira(M2));
                  Ancestor2(M1,Sira(M2)+1)=M2;
                  Sira(M1)=Sira(M2)+1;
                  Ancestor2(M2,Sira(M2)+1)=-1;
             
        
        elseif A==-1 && (B==3)  % infecting individual which is contact with presymptomatic individual
                    if rand()<Problar(z)
                       State(M1)=0;
                       Ancestor1(M1,1)=M2;
                       Time_Ancestor1(M1,1)=i;
                    end
                
                   Ancestor2(M1,1:Sira(M2))=Ancestor2(M2,1:Sira(M2));
                   Ancestor2(M1,Sira(M2)+1)=M2;
                   Sira(M1)=Sira(M2)+1;
                   Ancestor2(M2,Sira(M2)+1)=-1;
         
         elseif A==-1 && (B==4) % infecting individual which is contact with symptomatic individual
                    if rand()<Problar(z)
                       State(M1)=0;
                       Ancestor1(M1,1)=M2;
                       Time_Ancestor1(M1,1)=i;
                    end
                
                   Ancestor2(M1,1:Sira(M2))=Ancestor2(M2,1:Sira(M2));
                   Ancestor2(M1,Sira(M2)+1)=M2;
                   Sira(M1)=Sira(M2)+1;
                   Ancestor2(M2,Sira(M2)+1)=-1;
              %}  
                
        end
 
        
         z=z+1;
          if z==size(M,1)
             break
          end
  end
  
  % the state of each individual update after each 5 minutes time interval
  % using @StateUpdate function the 
  
           [State,counter]  = arrayfun(@StateUpdate,State,counter,counterlimit0,counterlimit1,counterlimit3,counterlimit4,a);
  
    % summ matrix store the totalnumber of :       
   summ(ws,1)=sum(State==0); % exposed
   summ(ws,2)=sum(State==1); % asymptomatic
   summ(ws,3)=sum(State==2); % recovered
   summ(ws,4)=sum(State==3); % presymptomatic 
   summ(ws,5)=sum(State==4); % symptomatic
   summ(ws,6)=sum(State==5);% hospitaliz
   
   
       ws=ws+1;
   i=i+1
   
    end
   
% saving ancestor1, ancestor2, totalcases, ans state matrix after first simulation       
Total_Ancestor1{sim_NO}=Ancestor1;
Total_Ancestor2{sim_NO}=Ancestor2;
TotalVaka{sim_NO}=summ(:,6);
State_counter{sim_NO}=State;

summ=[];

% choosing 2 individual with exposed, asymptomatic, presymptomatic, or
% asymptomatic
 if size(State,1)==469
State(:,2)=1:469;
State(:,3)=counter;
TR11=find(State(:,1)~=5);
TR12=State(TR11,:);
TR1=find(TR12(:,1)~=-1);
TR2=TR12(TR1,:);
TRR1=find(TR2(:,1)~=2);
TRR2=TR2(TRR1,:);
    else
 State(:,2)=1:468;
State(:,3)=counter;
TR11=find(State(:,1)~=5);
TR12=State(TR11,:);
TR1=find(TR12(:,1)~=-1);
TR2=TR12(TR1,:);
TRR1=find(TR2(:,1)~=2);
TRR2=TR2(TRR1,:);
    end
    
if size(TRR2,1)>=2
    TR3=randperm(size(TRR2,1));
    TR3=TR3(1:2);
    TR3=TR3';
    TR4=TRR2(TR3,:);
    State=((-1*ones(POP,1)));   
    State(TR4(:,2))=TR4(:,1);
    counter=((zeros(POP,1)));
    counter(TR4(:,2))=TR4(:,3);
    
else
    TR3=randperm(size(TRR2,1));
    TR3=TR3(1:size(TRR2,1));
    TR3=TR3';
    TR4=TRR2(TR3,:); % this matrix contain individual(s) which are/is choosen for starting seconde 
                     % simulation with
    State=((-1*ones(POP,1)));   
    State(TR4(:,2))=TR4(:,1);
    counter=((zeros(POP,1)));
    counter(TR4(:,2))=TR4(:,3);
end

    init_exp{sim_NO}=TR4;% saving TR4 matrix
   
  
 else 
     
      
 i=1;
 z=1;
  
     % starting second simulation for 14 days which equal to 2688 5 minute time interval
    while i<2689
    
    
    
  while M(z,1)==i
        M1=M(z,2);
        M2=M(z,3);
       
        A=State(M1);
        B=State(M2);
        
        if A==-1 && (B==1)
            load('FNM_HOME_5m+20m_symmetry');
    w=ismember([M1 M2],FNM_Home,'rows');
             if w==1
                  if rand()<0.696*Problar(z)
                     State(M1)=0;
                     Ancestor1(M1,1)=M2;
                     Time_Ancestor1(M1,1)=i;
                  end
             else 
                   if rand()<0.42*Problar(z)
                      State(M1)=0;
                      Ancestor1(M1,1)=M2;
                      Time_Ancestor1(M1,1)=i;
                   end
             end
            
                  Ancestor2(M1,1:Sira(M2))=Ancestor2(M2,1:Sira(M2));
                  Ancestor2(M1,Sira(M2)+1)=M2;
                  Sira(M1)=Sira(M2)+1;
                  Ancestor2(M2,Sira(M2)+1)=-1;
            
        
        elseif A==-1 && (B==3)
                    if rand()<Problar(z)
                       State(M1)=0;
                       Ancestor1(M1,1)=M2;
                       Time_Ancestor1(M1,1)=i;
                    end
             
                   Ancestor2(M1,1:Sira(M2))=Ancestor2(M2,1:Sira(M2));
                   Ancestor2(M1,Sira(M2)+1)=M2;
                   Sira(M1)=Sira(M2)+1;
                   Ancestor2(M2,Sira(M2)+1)=-1;
        
        elseif A==-1 && (B==4)
                    if rand()<Problar(z)
                       State(M1)=0;
                       Ancestor1(M1,1)=M2;
                       Time_Ancestor1(M1,1)=i;
                    end
                 
                   Ancestor2(M1,1:Sira(M2))=Ancestor2(M2,1:Sira(M2));
                   Ancestor2(M1,Sira(M2)+1)=M2;
                   Sira(M1)=Sira(M2)+1;
                   Ancestor2(M2,Sira(M2)+1)=-1;
              %}   
        end
                   
 
        
         z=z+1;
          if z==size(M,1)
             break
          end
  end
  
           [State,counter]  = arrayfun(@StateUpdate,State,counter,counterlimit0,counterlimit1,counterlimit3,counterlimit4,a);
   
   summ(ws,1)=sum(State==0);
   summ(ws,2)=sum(State==1);
   summ(ws,3)=sum(State==2);
   summ(ws,4)=sum(State==3);
   summ(ws,5)=sum(State==4);
   summ(ws,6)=sum(State==5);
   
       
       ws=ws+1;
   i=i+1
   
    end
  
Total_Ancestor1{sim_NO}=Ancestor1;
Total_Ancestor2{sim_NO}=Ancestor2;
TotalVaka{sim_NO}=summ(:,6);
State_counter{sim_NO}=State;


end
 end

Problar1=mean(Problar); 
Problar1_OH1=mean(Problar1_OH);
Problar1_IH1=mean(Problar1_IH);
end

