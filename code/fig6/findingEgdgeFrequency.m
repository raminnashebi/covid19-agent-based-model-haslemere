%% Finding Edge Frequency of Contact Networks

M=csvread('Kissler_DataS1.csv');% Halsemere dataset (real contact network)
M(M(:,4)>20,:)=[];% Deleting interaction which occured more than 20 meters distance

% Obtainig  contact network for each day separatly from M (14 day expanded
% contact matrix).
% Halsemere dataset make contact network of individual for 16 hour each day
% (thursday, friday, saturday)from 07:00 AM upto 22:55 PM. there is 12*16=192 five minut time interval
% each day.For example 7:00 AM up 07:05 AM is 1.In expanded version of contact network  for 14 day there is
% total of 2688 five minute time step. For example from 1 upto 192 is monday 
% of first week. 
x1=find(M(:,1)==192); 
x2=find(M(:,1)==384);
x3=find(M(:,1)==576);
x4=find(M(:,1)==768);
x5=find(M(:,1)==960);
x6=find(M(:,1)==1152);
x7=find(M(:,1)==1344);
x8=find(M(:,1)==1536);
x9=find(M(:,1)==1728);
x10=find(M(:,1)==1920);
x11=find(M(:,1)==2112);
x12=find(M(:,1)==2304);
x13=find(M(:,1)==2496);

M1=M(1:x1(end),:); % Monday contact network
M2=M(x1(end)+1:x2(end),:); % Tuesday contact network 
M3=M(x2(end)+1:x3(end),:);% Wednsday contact network
M4=M(x3(end)+1:x4(end),:);% Thursday contact network
M5=M(x4(end)+1:x5(end),:);% Friday contact network
M6=M(x5(end)+1:x6(end),:);% Saturday contact network
M7=M(x6(end)+1:x7(end),:);% Sunday contact network
M8=M(x7(end)+1:x8(end),:);%  Monday  contact network
M9=M(x8(end)+1:x9(end),:);% Tuesday contact network
M10=M(x9(end)+1:x10(end),:);% Wednsday contact network
M11=M(x10(end)+1:x11(end),:);% Thursday contact network
M12=M(x11(end)+1:x12(end),:);% Friday contact network
M13=M(x12(end)+1:x13(end),:);% Saturday contact network
M14=M(x13(end)+1:end,:);% Sunday contact network

% In here we assume work hour start from 09:00 AM up to 06:00 PM for 9 hour
% on weekday

    w=(12*9)+24; % From which day you want to reduce work hour (in here 
                 % its Monday of first week) 
    w0=(12*(Working_hour-1))+24; % How many hour do you want to reduce 
                                 % (if working_hour=9 so there will be 1 
                                 % hour work hour reduction in day)
    
    w2=find(M1(:,1)==w0+1); 
    w3=find(M1(:,1)==w);
    w4=M1(w2(1,1)+1:w3(end,1),:); 
    w5=M1(w3(end,1)+1:size(M1,1),:);
    
   
    load('FNM_HOME_5m+20m_time_symmetry'); % import home contact network
    load('FNM_WORK_5m+20m_time_symmetry'); % import work contact network
    load('FNM_OUTDOOR_5m+20m_time_symmetry'); % import nonhousehold contact network
    
    % Changing work hour of Monday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail) 
    for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M1(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');% this matrix catch the ith interaction in M1 contact network is 
                                                                    % occured in workplace or not?   
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M1(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M1(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]); % changing work edge with home and social environment edge
                                                                                    % which occured at ith time interval
           else
               iii=ismember(w5(:,3),M1(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M1(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);% changing work edge with home and social environment edge
                                                                                    % which occured at ith time interval
               else
                   M1(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
    end
    
    
    w2=[];
    w3=[];
    w5=[];  
      
     
    w=(12*9)+24+192; % From which day you want to reduce working hour (in here 
                     % its Tuseday of first week) 
    w0=(12*(Working_hour-1))+24+192;
    w2=find(M2(:,1)==w0+1);
    w3=find(M2(:,1)==w);
    w5=M2(w3(end,1)+1:size(M2,1),:);
    
    % Changing work hour of Tuseday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail) 
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M2(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M2(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M2(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M2(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M2(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M2(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
    
     w2=[];
    w3=[];
    w5=[];


     w=(12*9)+24+384;% From which day you want to reduce working hour (in here 
                     % its wednsday of first week) 
    w0=(12*(Working_hour-1))+24+384;
    w2=find(M3(:,1)==w0+1);
    w3=find(M3(:,1)==w);
    w5=M3(w3(end,1)+1:size(M3,1),:);
    
    % Changing work hour of wednsday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail) 
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M3(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M3(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M3(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M3(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M3(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M3(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
    
     w2=[];
    w3=[];
    w5=[];


      w=(12*9)+24+576;% From which day you want to reduce working hour (in here 
                      % its Thursday of first week) 
    w0=(12*(Working_hour-1))+24+576;
    w2=find(M4(:,1)==w0+1);
    w3=find(M4(:,1)==w);
    w5=M4(w3(end,1)+1:size(M4,1),:);
    
    % Changing work hour of Thursday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M4(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M4(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M4(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M4(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M4(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M4(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
    
     w2=[];
    w3=[];
    w5=[];

 
      w=(12*9)+24+768;% From which day you want to reduce working hour (in here 
                     % its friday of first week) 
    w0=(12*(Working_hour-1))+24+768;
    w2=find(M5(:,1)==w0+1);
    w3=find(M5(:,1)==w);
    w5=M5(w3(end,1)+1:size(M5,1),:);
    
    % Changing work hour of friday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M5(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M5(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M5(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M5(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M5(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M5(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

 
      w=(12*9)+24+960;% From which day you want to reduce working hour (in here 
                      % its Saturday of first week) 
    w0=(12*(Working_hour-1))+24+960;
    w2=find(M6(:,1)==w0+1);
    w3=find(M6(:,1)==w);
    w5=M6(w3(end,1)+1:size(M6,1),:);
    
    % Changing work hour of Saturday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M6(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M6(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M6(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M6(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M6(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M6(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

    
    
      w=(12*9)+24+1152;% From which day you want to reduce working hour (in here 
                      % its Sunday of first week) 
    w0=(12*(Working_hour-1))+24+1152;
    w2=find(M7(:,1)==w0+1);
    w3=find(M7(:,1)==w);
    w5=M7(w3(end,1)+1:size(M7,1),:);
    
    % Changing work hour of Saturday contact network of first week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M7(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M7(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M7(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M7(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M7(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M7(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

    
    
      w=(12*9)+24+1344;% From which day you want to reduce working hour (in here 
                      % its Monday of second week) 
    w0=(12*(Working_hour-1))+24+1344;
    w2=find(M8(:,1)==w0+1);
    w3=find(M8(:,1)==w);
    w5=M8(w3(end,1)+1:size(M8,1),:);
    
    % Changing work hour of Monday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M8(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M8(i,2),'rows');
           if ii==1
           insertion_mtrx=w8(ii,:);
           M8(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M8(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M8(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M8(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];


    w=(12*9)+24+1536;% From which day you want to reduce working hour (in here 
                      % its Tuesday of second week) 
    w0=(12*(Working_hour-1))+24+1536;
    w2=find(M9(:,1)==w0+1);
    w3=find(M9(:,1)==w);
    w5=M9(w3(end,1)+1:size(M9,1),:);
    
    % Changing work hour of Tuesday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M9(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M9(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M9(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M9(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M9(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M9(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];


    w=(12*9)+24+1728; % From which day you want to reduce working hour (in here 
                      % its wednsday of second week)
    w0=(12*(Working_hour-1))+24+1728;
    w2=find(M10(:,1)==w0+1);
    w3=find(M10(:,1)==w);
    w5=M10(w3(end,1)+1:size(M10,1),:);
    
    % Changing work hour of wednsday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M10(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M10(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M10(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M10(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M10(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M10(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];


    w=(12*9)+24+1920; % From which day you want to reduce working hour (in here 
                      % its Thursday of second week)
    w0=(12*(Working_hour-1))+24+1920;
    w2=find(M11(:,1)==w0+1);
    w3=find(M11(:,1)==w);
    w5=M11(w3(end,1)+1:size(M11,1),:);
    
    % Changing work hour of Thursday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M11(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M11(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M11(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M11(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M11(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M11(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

    
    w=(12*9)+24+2112; % From which day you want to reduce working hour (in here 
                      % its Friday of second week)
    w0=(12*(Working_hour-1))+24+2112;
    w2=find(M12(:,1)==w0+1);
    w3=find(M12(:,1)==w);
    w5=M12(w3(end,1)+1:size(M12,1),:);
    
    % Changing work hour of Friday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M12(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M12(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M12(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M12(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M12(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M12(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

    
    w=(12*9)+24+2304;% From which day you want to reduce working hour (in here 
                     % its Saturday of second week)
    w0=(12*(Working_hour-1))+24+2304;
    w2=find(M13(:,1)==w0+1);
    w3=find(M13(:,1)==w);
    w5=M13(w3(end,1)+1:size(M13,1),:);
    
    % Changing work hour of Saturday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M13(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M13(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M13(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M13(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M13(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M13(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

    
    
    w=(12*9)+24+2496;% From which day you want to reduce working hour (in here 
                     % its Sunday of second week)
    w0=(12*(Working_hour-1))+24+2496;
    w2=find(M14(:,1)==w0+1);
    w3=find(M14(:,1)==w);
    w5=M14(w3(end,1)+1:size(M14,1),:);
    
    % Changing work hour of Sunday contact network of second week by replacing work edges with home and social
    % environment edges (see method and material for more detail)
    
     for i=w2(1,1):w3(end,1)
       wrk_mmbr=ismember(M14(i,[2 3]),FNM_Work_time(:,[2 3]),'rows');
       if wrk_mmbr==1
           ii=ismember(w5(:,2),M14(i,2),'rows');
           if ii==1
           insertion_mtrx=w5(ii,:);
           M14(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
           else
               iii=ismember(w5(:,3),M14(i,3),'rows');
               if iii==1
                    insertion_mtrx=w5(ii,:);
                    M14(i,[2 3 4])=insertion_mtrx(randi(size(insertion_mtrx,1),1,1),[2 3 4]);
               else
                   M14(i,[2 3 4])=w5(randi(size(w5,1),1,1),[2 3 4]);
               end
           end
       end
     end
   
     w2=[];
    w3=[];
    w5=[];

 % Rearranging M contact network after work hour decrease
    Mnew(1:size(M1,1),1:4)=M1;
Mnew(size(M1,1)+1:size(M2,1)+size(M1,1),1:4)=M2;
Mnew(size(M1,1)+size(M2,1)+1:size(M3,1)+size(M2,1)+size(M1,1),1:4)=M3;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+1:size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M4;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+1:size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M5;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+1:size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M6;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+1:size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M7;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+1:size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M8;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+size(M8,1)+1:size(M9,1)+size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M9;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+size(M8,1)+size(M9,1)+1:size(M10,1)+size(M9,1)+size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M10;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+size(M8,1)+size(M9,1)+size(M10,1)+1:size(M11,1)+size(M10,1)+size(M9,1)+size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M11;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+size(M8,1)+size(M9,1)+size(M10,1)+size(M11,1)+1:size(M12,1)+size(M11,1)+size(M10,1)+size(M9,1)+size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M12;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+size(M8,1)+size(M9,1)+size(M10,1)+size(M11,1)+size(M12,1)+1:size(M13,1)+size(M12,1)+size(M11,1)+size(M10,1)+size(M9,1)+size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M13;
Mnew(size(M1,1)+size(M2,1)+size(M3,1)+size(M4,1)+size(M5,1)+size(M6,1)+size(M7,1)+size(M8,1)+size(M9,1)+size(M10,1)+size(M11,1)+size(M12,1)+size(M13,1)+1:size(M14,1)+size(M13,1)+size(M12,1)+size(M11,1)+size(M10,1)+size(M9,1)+size(M8,1)+size(M7,1)+size(M6,1)+size(M5,1)+size(M4,1)+size(M3,1)+size(M2,1)+size(M1,1),1:4)=M14;

M=Mnew; % Our 14 day Contact network after decreasing work hour (altered contact network)
                                                                                                             

load('FNM_HOME_5m+20m_time'); % Household contact network
load('FNM_WORK_5m+20m_time'); % Workplace contact network
load('FNM_OUTDOOR_5m+20m_time') % Social environment contact network

% counting edge frequency of real and altered contact network 

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
    
    %plotting
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