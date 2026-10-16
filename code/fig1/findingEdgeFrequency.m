%% Finding Edge Frequency of Contact Networks 

% Finding and plotting number of 5min encounters hourly for three consecutive day (Thursday, Friday, Saturday)   

% Entering contact network Matrixs

M=csvread('Kissler_DataS1.csv');% Halsemere dataset
M(M(:,4)>20,:)=[];% Deleting interaction which occured more than 20 meters distance

load('FNM_HOME_5m+20m_time'); % Household contact network
load('FNM_WORK_5m+20m_time'); % Workplace contact network
load('FNM_OUTDOOR_5m+20m_time') % Social environment contact network

% counting edge frequency of real contact network 
cntr1=1;
for v3=4:5:25
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