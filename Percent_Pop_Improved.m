function [Avg_Change,SD_mean,Change_percent,SD_percent,percent_decline,percent_no_change,Average_Decline,Average_No_change] = Percent_Pop_Improved(score_struc)
%% This function describes statistics following a trial simulation to describe the number of patients that
% have an improvement in fibrosis score of 1 or more.

%% Initialize final score structure
    for i=1:5
        F0(:,i)=(score_struc(1).model(:,i));
        F1(:,i)=(score_struc(2).model(:,i));
        F2(:,i)=(score_struc(3).model(:,i));
        F3(:,i)=(score_struc(4).model(:,i));
        F4(:,i)=(score_struc(5).model(:,i));
    end

NF0I=sum(F0(:,:));
NF1I=sum(F1(:,:));
NF2I=sum(F2(:,:));
NF3I=sum(F3(:,:));
NF4I=sum(F4(:,:));

NFtotal= [NF0I,NF1I,NF2I,NF3I,NF4I];
NFtotal=sum(NFtotal);

deltapos1=[sum(F0(:,2))+sum(F1(:,3))+sum(F2(:,4))+sum(F3(:,5))];
deltapos2=[sum(F0(:,3))+sum(F1(:,4))+sum(F2(:,5))] ;
deltapos3=[sum(F0(:,4))+sum(F1(:,5))] ;
deltapos4=[sum(F0(:,5))];
deltaneg1=[sum(F1(:,1))+sum(F2(:,2))+sum(F3(:,3))+sum(F4(:,4))] ;
deltaneg2=[sum(F2(:,1))+sum(F3(:,2))+sum(F4(:,3))];
deltaneg3=[sum(F3(:,1))+sum(F4(:,2))];
deltaneg4=[sum(F4(:,1))];

%% Calculating Mean and SD for each iteration and percent population with inproved fibrosis score
% j is the number of times the simulation was run with the same starting
% distribution
Total=sum(score_struc(1).data) + sum(score_struc(2).data)+sum(score_struc(3).data)+sum(score_struc(4).data)+sum(score_struc(5).data);
    for j=1:numel(score_struc(1).model(:,1))

        deltainc1(j)=[sum(F0(j,2))+sum(F1(j,3))+sum(F2(j,4))+sum(F3(j,5))];
        deltainc2(j)=[sum(F0(j,3))+sum(F1(j,4))+sum(F2(j,5))] ;
        deltainc3(j)=[sum(F0(j,4))+sum(F1(j,5))] ;
        deltainc4(j)=[sum(F0(j,5))] ;
        deltadec1(j)=[sum(F1(j,1))+sum(F2(j,2))+sum(F3(j,3))+sum(F4(j,4))] ;
        deltadec2(j)=[sum(F2(j,1))+sum(F3(j,2))+sum(F4(j,3))];
        deltadec3(j)=[sum(F3(j,1))+sum(F4(j,2))] ;
        deltadec4(j)=[sum(F4(j,1))];

        Sum_Change(j)=deltadec1(j)+deltadec2(j)+deltadec3(j)+deltadec4(j);
        Change_percent(j)=Sum_Change(j)./Total*100 ; % Percent population improved


        Decline(j)=deltainc1(j)+ deltainc2(j) + deltainc3(j) + deltainc4(j);
        percent_decline(j)=Decline(j)./Total*100;


        No_change(j)=Total-Decline(j)-Sum_Change(j);
        percent_no_change(j)=No_change(j)./Total*100;

        SD_percent= std(Change_percent);

    end
%% Averages
SD_mean=std(Sum_Change);
Avg_Change=mean(Sum_Change); %Average Change in Fibrosis mean for 200 simulations with the same distribution

Average_Decline=mean(Decline);
Average_No_change=mean(No_change);


end
