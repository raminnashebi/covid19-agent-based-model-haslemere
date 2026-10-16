%% Ploting Errorbar of  Figure 2b and 2c
% Required Matrixs: 1) Householf infection ratio matrix
%                   2) workplace infection ratio matrix
%                   3) social environment ratio matrix
%                   4) Basic reproduction number matrix which calculated
%                      for 500 simulation with 9 different transmission ratio 

figure
for i=1:9 % we did 500 simulation for 9 different transmission rates
    total_ratio=R_AH(:,i)+R_AW(:,i)+R_AO(:,i);% total infection ratio of household, workplace, and social environment
    f1=find(total_ratio==0);
    RAH=R_AH(:,i);
    RAH(f1)=[];
SEM1=std(RAH)/sqrt(length(RAH))
ts1 = tinv([0.025  0.975],length(RAH)-1);  
CI1 = mean(RAH) + ts1*SEM1;  % confidence interval of household infection ratio 
CIdist1(i,:)=abs(CI1-mean(RAH));% Error bars
x(:,i)=mean(RAH,1); % Average of household infection ration  
end
CIdist1=CIdist1(1:end,:);
x=x';
shadedErrorBar(mean(R0_final1(:,1:9)),x,CIdist1,'lineprops','-b','patchSaturation',0.10)% ploting shaded Error bar
hold on
x=[];
CIdist1=[];

for i=1:9
    total_ratio=R_AH(:,i)+R_AW(:,i)+R_AO(:,i);
    f2=find(total_ratio==0);
    RAO=R_AO(:,i);%social environment infection ratio
    RAO(f2)=[];
SEM1=std(RAO)/sqrt(length(RAO))
ts1 = tinv([0.025  0.975],length(RAO)-1);  
CI1 = mean(RAO) + ts1*SEM1;  % confidence interval of social environment infection ratio
CIdist1(i,:)=abs(CI1-mean(RAO));% Error bars
x(:,i)=mean(RAO,1);% Average of social environment infection ratio

end
CIdist1=CIdist1(1:end,:);
x=x';
shadedErrorBar(mean(R0_final1(:,1:9)),x,CIdist1,'lineprops','-r','patchSaturation',0.10)% ploting shaded Error bar
hold on 
x=[];
CIdist1=[];


for i=1:9
    total_ratio=R_AH(:,i)+R_AW(:,i)+R_AO(:,i);
    f3=find(total_ratio==0);
    RAW=R_AW(:,i);
    RAW(f3)=[];
SEM1=std(RAW)/sqrt(length(RAW))
ts1 = tinv([0.025  0.975],length(RAW)-1);  
CI1 = mean(RAW) + ts1*SEM1;  % confidence interval of workplace infection ratio
CIdist1(i,:)=abs(CI1-mean(RAW));% Error bars
x(:,i)=mean(RAW,1);% Average of workplace infection ratio
end
CIdist1=CIdist1(1:end,:);
x=x';
shadedErrorBar(mean(R0_final1(:,1:9)),x,CIdist1,'lineprops','-g','patchSaturation',0.10)% ploting shaded Error bar
hold on 
x=[];
CIdist1=[];


 red_beta=100*(1-(Transmission_rate2./max(Transmission_rate2)));% Percentage reduction of transmission probability 
                                                                % is computed as a ratio of the effective-outside 
                                                                % transmission probability with respect to WT (default, estimated) 
                                                                % transmission% in here max((Transmission_rate2) is transmission 
                                                                % probability where R0 reach 2.87 (COVID-19 basic reproduction number) 
                                                             
                                                                
%% Ploting FIgure 2a
% Required Matrixes : 1) Basic reproduction number (R0) matrix which calculated
%                        for 500 simulation with 9 different transmission ratio 
%                     2) Percentage reduction of transmission probability
%                        vector
for i=1:9
SEM1=std(R0_final1(:,i))/sqrt(length(R0_final1(:,i)))% R0_final1 is Basic reproduction number (R0) matrix which calculated
                                                     % for 500 simulation with 9 different transmission ratio
ts1 = tinv([0.025  0.975],length(R0_final1(:,i))-1);  
CI1 = mean(R0_final1(:,i)) + ts1*SEM1;  % confidence interval of R0
CIdist1(i,:)=abs(CI1-mean(R0_final1(:,i)));% Error bar
x(:,i)=mean(R0_final1(:,i),1);% Average of R0 for each trasmision rate
end
CIdist1=CIdist1(1:end,:);
x=x';
shadedErrorBar(red_beta(1:9),x,CIdist1,'lineprops','-k','patchSaturation',0.10)% Ploting shaded Error bar
hold on 
x=[];
CIdist1=[];

