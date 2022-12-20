function [Average_Delta]=Change_Fib_Score(score_struc)
 
    for i=1:numel(score_struc(1).model(1,:))
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
        deltaneg4=[sum(F4(:,1))].*-4 ;
         
   
Sum_Change=deltapos1+deltapos2+deltapos3+deltapos4+deltaneg1+deltaneg2+deltaneg3+deltaneg4 ;

Average_Delta=Sum_Change/NFtotal ;

