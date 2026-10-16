%% Visualization methods

KisslerDataS1=csvread('Kissler_DataS1.csv');% importing Halsemere dataset
q=56;% agent 
d=50;% d?stance
T=KisslerDataS1((KisslerDataS1(:,2)==q|KisslerDataS1(:,3)==q),:);% Finding all interaction of q agent w?th d d?stance
                                                                 % during Thursday Friday and saturday
                                                                 
                                                            
List=[];
for i=1:size(T,1)
    List(i)=setdiff(T(i,[2,3]),q);% Collect agents wh?ch interact w?th q agent 

end
TT=[T(:,1),List',T(:,4)];% Matrix of agents which interact with q agent from d distance
clf

%Plotting agents versus distance for q agent during Thursday, Friday, and
%Saturday
plot(TT(TT(:,3)<=d,1)/192,TT(TT(:,3)<=d,2),'o')
hold on 
plot([145/192,145/192],[0,460])
plot([133/192,133/192],[0,475])
plot([337/192,337/192],[0,460])
plot([325/192,325/192],[0,475])
plot([373/192,373/192],[0,475])
plot([529/192,529/192],[0,460])
plot([25/192,25/192],[0,460])
plot([13/192,13/192],[0,475])
plot([217/192,217/192],[0,460])
plot([205/192,205/192],[0,475])
plot([409/192,409/192],[0,460])
plot([565/192,565/192],[0,475])