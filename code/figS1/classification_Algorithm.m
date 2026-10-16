%% Importing social network data. M is 

M=csvread('Kissler_DataS1.csv');

%% Take only interaction which occured between 6m and 20m distance 

    M(M(:,4)>20,:)=[];
    M1=M;
    M1(M1(:,4)<=5,:)=[];
   
%% clusturing interaction which 

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

U_20m_diff_5m(:,4)=0;
U_20m_diff_5m(:,3)=0;

 for i=1:size(U_20m_diff_5m,1)
    x=U_20m_diff_5m(i,[1 2]);
    L=ismember(U_20m_time(:,[2 3]),x,'rows');
    L=U_20m_time(L,:);
    U_20m_diff_5m(i,4)=size(L,1);
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
   
    %%
   
    if size(L,1)<=80
    if size(L,1)>15
        if H_O_time>W_time
             U_20m_diff_5m(i,3)=1;
        else
             U_20m_diff_5m(i,3)=2;
        end
    else
        if H_O_time>W_time
             U_20m_diff_5m(i,3)=3;
        else
             U_20m_diff_5m(i,3)=2;
        end
    end
    else
            U_20m_diff_5m(i,3)=1
    end
    
    
end