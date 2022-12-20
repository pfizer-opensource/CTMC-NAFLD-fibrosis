function [SD_mean,Avg_SD,Avg_Change]=Change_Fib_ScoreRSD(score_struc)

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


%% Average change in score
% Find the change in score for each patient
Average_Score_Before=sum(NF0I*0 + NF1I*1 +NF2I*2 + NF3I*3 + NF4I*4)/NFtotal;

deltapos1=[sum(F0(:,2))+sum(F1(:,3))+sum(F2(:,4))+sum(F3(:,5))].*1 ;
deltapos2=[sum(F0(:,3))+sum(F1(:,4))+sum(F2(:,5))].*2 ;
deltapos3=[sum(F0(:,4))+sum(F1(:,5))].*3 ;
deltapos4=[sum(F0(:,5))].*4 ;
deltaneg1=[sum(F1(:,1))+sum(F2(:,2))+sum(F3(:,3))+sum(F4(:,4))].*-1 ;
deltaneg2=[sum(F2(:,1))+sum(F3(:,2))+sum(F4(:,3))].*-2 ;
deltaneg3=[sum(F3(:,1))+sum(F4(:,2))].*-3 ;
deltaneg4=[sum(F4(:,1))].*-4  ;


Sum_Change_total=deltapos1+deltapos2+deltapos3+deltapos4+deltaneg1+deltaneg2+deltaneg3+deltaneg4 ;
Average_Delta=Sum_Change_total/NFtotal ;

%% Calculating SD for each iteration and Average Change in Fibrosis score
% j is the number of times the simulation was run with the same starting
% distribution
Total=sum(score_struc(1).data) + sum(score_struc(2).data)+sum(score_struc(3).data)+sum(score_struc(4).data)+sum(score_struc(5).data);
    for j=1:numel(score_struc(1).model(:,1))

        deltainc1(j)=[sum(F0(j,2))+sum(F1(j,3))+sum(F2(j,4))+sum(F3(j,5))].*1 ;
        deltainc2(j)=[sum(F0(j,3))+sum(F1(j,4))+sum(F2(j,5))].*2 ;
        deltainc3(j)=[sum(F0(j,4))+sum(F1(j,5))].*3 ;
        deltainc4(j)=[sum(F0(j,5))].*4 ;
        deltadec1(j)=[sum(F1(j,1))+sum(F2(j,2))+sum(F3(j,3))+sum(F4(j,4))].*-1 ;
        deltadec2(j)=[sum(F2(j,1))+sum(F3(j,2))+sum(F4(j,3))].*-2 ;
        deltadec3(j)=[sum(F3(j,1))+sum(F4(j,2))].*-3 ;
        deltadec4(j)=[sum(F4(j,1))].*-4 ;

        Sum_Change(j)=deltainc1(j)+deltainc2(j)+deltainc3(j)+deltainc4(j)+deltadec1(j)+deltadec2(j)+deltadec3(j)+deltadec4(j);
        Change(j)=Sum_Change(j)./Total ; % Average change in fibrosis score

        % SD vector captures the number of patients from each final distribution
        %mthat increased by 1,2,3,4 or decreased by 1,2,3,and 4

        SD_Vector(j,:)=[deltainc1(j),deltainc2(j),deltainc3(j),deltainc4(j),deltadec1(j),deltadec2(j),deltadec3(j),deltadec4(j)];
        SD=SD_sum_Change(SD_Vector,Total);
    end
SD_mean=std(Change);
Avg_Change=mean(Change); % Average Change in Fibrosis mean for 500 simulations with the same distribution
Avg_SD=mean(SD) ;        % Average Standard deviation of 500 simulations with same distribution
end