%% Testing Classification Algorithm 
% We test our algorithm on already classified data by visualization method

% Loading social network data as a MATLAB matrix (M)
M=csvread('Kissler_DataS1.csv');
    M(M(:,4)>5,:)=[];
% Loading 
    load('FNM_HOME_5m+20m_symmetry.mat'); 
    load('FNM_OUTDOOR_5m+20m_symmetry.mat'); 
    load('FNM_WORK_5m+20m_symmetry.mat'); 
    
A=1:12; A=A';
B=13:132; B=B';
C=133:192; C=C';
A1=193:204; A1=A1';
B1=205:324; B1=B1';
C1=325:384; C1=C1';
A2=385:396; A2=A2';
B2=397:516; B2=B2';
C2=517:576; C2=C2';

UA=union(A,union(A1,A2,'rows'),'rows');
UC=union(C,union(C1,C2,'rows'),'rows');
UB=union(B,union(B1,B2,'rows'),'rows');

Munique(:,4)=0;
Munique(:,3)=0;

for i=1:size(Munique,1)
    x=Munique(i,[1 2]);
    L=ismember(M(:,[2 3]),x,'rows');
    L=M(L,:);
    Munique(i,4)=size(L,1);
    y=L(:,1);
    yA=ismember(y,A,'rows');
    yB=ismember(y,B,'rows');
    yC=ismember(y,C,'rows');
    yA1=ismember(y,A1,'rows');
    yB1=ismember(y,B1,'rows');
    yC1=ismember(y,C1,'rows');
    yA2=ismember(y,A2,'rows');
    yB2=ismember(y,B2,'rows');
    yC2=ismember(y,C2,'rows');
    H_O_time=sum(yA)+sum(yA1)+sum(yA2)+sum(yC)+sum(yC1)+sum(yC2)+sum(yB2);
    W_time=sum(yB)+sum(yB1);
   
    if size(L,1)<=80 
    
    if size(L,1)>15
        if H_O_time>W_time
             Munique(i,3)=1;
        else
             Munique(i,3)=2;
        end
    else
        if H_O_time>W_time
             Munique(i,3)=3;
        else
             Munique(i,3)=2;
        end
    end
    
    else
        Munique(i,3)=1;
    end
    
end

H_10=find(Munique(:,3)==1);
W_10=find(Munique(:,3)==2);
O_10=find(Munique(:,3)==3);

x1=ismember(FNM_Home,Munique(H_10,[1 2]),'rows');
x2=ismember(FNM_Work,Munique(W_10,[1 2]),'rows');
x3=ismember(FNM_Outdoor,Munique(O_10,[1 2]),'rows');

x1=sum(x1);
x2=sum(x2);
x3=sum(x3);

H_identify_10=(100*x1)/size(FNM_Home,1);
W_identify_10=(100*x2)/size(FNM_Work,1);
O_identify_10=(100*x3)/size(FNM_Outdoor,1);

H_c=(100*x1)/1350;
W_c=(100*x2)/1350;
O_c=(100*x3)/1350;


