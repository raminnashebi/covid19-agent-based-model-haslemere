%% Finding Edge Frequency of Contact Networks



M=csvread('Kissler_DataS1.csv');% Halsemere dataset (real contact network)
M(M(:,4)>20,:)=[];% Deleting interaction which occured more than 20 meters distance

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
                                                                                                             

load('FNM_HOME_5m+20m_time'); % Household contact network
load('FNM_WORK_5m+20m_time'); % Workplace contact network
load('FNM_OUTDOOR_5m+20m_time') % Social environment contact network

% counting edge frequency of altered contact network 

cntr1=1;
for v3=4
    trgt_M=M(:,cntr1:v3)
    cntr2=1;
    cntr3=1;
    for v4=12:12:564 % 5min encounters hourly 
        fnd=find(trgt_M(:,1)==v4);
        trgt_SM=trgt_M(cntr2:fnd(end),:);% store interactions of specific hour which 
                                         % want to identify their occurence environment 
    fnd_w=ismember(trgt_SM(:,[2 3]),FNM_Work_time(:,[2 3]),'rows'); % encounters which occured in workplace 
    fnd_h=ismember(trgt_SM(:,[2 3]),FNM_Home_time(:,[2 3]),'rows'); % encounters which cccured in household 
    fnd_o=ismember(trgt_SM(:,[2 3]),FNM_Outdoor_time(:,[2 3]),'rows'); % encounters which cccured in social 
                                                                       % environment 
    num_w(cntr3)=sum(fnd_w);% number of encounters which occured in workplace 
    num_h(cntr3)=sum(fnd_h);% number of encounters which cccured in household
    num_o(cntr3)=sum(fnd_o);% number of encounters which cccured in social environment
                                                                      
    cntr2=1+fnd(end,1);
    cntr3=cntr3+1;
    trgt_SM=[];
    end
    
    % plotting
    figure
    plot(num_h,'b')
    hold on
    plot(num_w,'g')
    hold on
    plot(num_o,'r')
   
    cntr1=cntr1+5;
    trgt_M=[];
    num_w=[];
    num_h=[];
    num_o=[];
end