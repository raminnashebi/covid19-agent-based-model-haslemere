%% Plotting Errorbars of OHO OOO OHH OHH ... 

% Required Matrix: Third order infetion chains occurence ratio (ydata_ratio)

y=[1 1 1; 1 1 2; 1 2 1; 2 1 1; 1 2 2; 2 1 2; 2 2 1; 2 2 2];
u1=4;

for i=1:8
    target_chain=ydata_ratio(i,:);
    target_chain=target_chain';
  
SEM1=std(target_chain(:,1))/sqrt(length(target_chain(:,1)));
ts1 = tinv([0.025  0.975],length(target_chain(:,1))-1);  
CI1 = mean(target_chain(:,1)) + ts1*SEM1;  
CIdist1(i,:)=abs(CI1-mean(target_chain(:,1)));

 
bar(u1,mean(target_chain(:,1)),'FaceColor',[0.756862759590149 0.866666674613953 0.776470601558685],'EdgeColor',[0.756862759590149 0.866666674613953 0.776470601558685])

bar(u1,mean(target_chain(:,1)),'FaceColor',[0.925490200519562 0.839215695858002 0.839215695858002],...
   'EdgeColor',[0.925490200519562 0.839215695858002 0.839215695858002]);

bar(u1,mean(target_chain(:,1)),'FaceColor',[0.729411780834198 0.831372559070587 0.95686274766922],...
   'EdgeColor',[0.729411780834198 0.831372559070587 0.95686274766922]);

 bar(u1,mean(target_chain(:,1)),'FaceColor',[0.952941179275513 0.87058824300766 0.733333349227905],...
  'EdgeColor',[0.952941179275513 0.87058824300766 0.733333349227905]);

bar(u1,mean(target_chain(:,1)),'FaceColor',[0.862745106220245 0.862745106220245 0.862745106220245],...
  'EdgeColor',[0.862745106220245 0.862745106220245 0.862745106220245]);

bar(u1,mean(target_chain(:,1)),'FaceColor',[1 0.600000023841858 0.600000023841858],...
   'EdgeColor',[1 0.600000023841858 0.600000023841858],...
   'BarWidth',1);

hold on 
errorbar(u1,mean(target_chain(:,1)),CIdist1(1,1),CIdist1(1,2),'k');
u1=u1+8
target_chain=[];
end
