
%% Calculating infection occurence environment 
%Required Matrixs: 1)Total_Ancestor1
%                  2)Household contact network 
%                  3)Workplace contact network
%                  4)Social environment contact network

load('FNM_HOME_5m+20m_symmetry'); % Household contact network
load('FNM_WORK_5m+20m_symmetry'); % Workplace contact network
load('FNM_OUTDOOR_5m+20m_symmetry')% Social environment contact network

 for k=1:9
for j=1:500
   
    
        Ancestor(:,2)=Total_Ancestor1{j,k}{1,2};% descendants matrix of agents  
        Ancestor(:,1)=1:size(Ancestor(:,2),1);
        L=find(Ancestor(:,2)==0);% agents with exposed stage
         q=find(Ancestor(:,2)==-1);% agents with susceptible 
        Ancestor(q,:)=[];
       

a1=ismember(Ancestor(:,[1 2]),FNM_Home(:,1:2),'rows');% indicating househod infectious interactions  
a2=ismember(Ancestor(:,[1 2]),FNM_Work(:,1:2),'rows');% indicating workplace infectious interactions  
a3=ismember(Ancestor(:,[1 2]),FNM_Outdoor(:,1:2),'rows');% indicating social environment infectious interactions 
Result=zeros(size(Ancestor,1),1);
Result(a1)=1;
Result(a2)=2;
Result(a3)=3;


aH{j,k}=sum(a1,1);
aW{j,k}=sum(a2,1);
aO{j,k}=sum(a3,1);

Ancestor=[];
a1=[];
a2=[];
a3=[];
   
    end
end


for j=1:9
for i=1:500    
AH(i,j)=aH{i,j};
AO(i,j)=aO{i,j};
AW(i,j)=aW{i,j};
end
end

% Number of infection RATIO 

toplam=AH+AO+AW; % total number of infection (Household+workplace+social environment)
R_AH=AH./toplam; % Household infection ratio
R_AO=AO./toplam; % Social environement infection ratio
R_AW=AW./toplam; % workplace infection ratio


% Deleting undefined ratios (NAN)
for j=1:9

k=find(isnan(R_AW(:,j)));
R_AW(k,j)=0;
end

for j=1:9

k=find(isnan(R_AO(:,j)));
R_AO(k,j)=0;
end

for j=1:9
k=find(isnan(R_AH(:,j)));
R_AH(k,j)=0;
end


