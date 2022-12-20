function [med_struc]= median_output(score_struc,NF_total,Data)
% converts distribution to median output for each iteration
med_struc=struct;

InitialDist1=[1 0 0 0 0];
InitialDist2=[0 1 0 0 0];
InitialDist3=[0 0 1 0 0];
InitialDist4=[0 0 0 1 0];
InitialDist5=[0 0 0 0 1];

med_struc(1).medF0(1,:)=InitialDist1;
med_struc(1).medF1(1,:)=InitialDist2;
med_struc(1).medF2(1,:)=InitialDist3;
med_struc(1).medF3(1,:)=InitialDist4;
med_struc(1).medF4(1,:)=InitialDist5;

med_struc(1).dataF0(1,:)=InitialDist1;
med_struc(1).dataF1(1,:)=InitialDist2;
med_struc(1).dataF2(1,:)=InitialDist3;
med_struc(1).dataF3(1,:)=InitialDist4;
med_struc(1).dataF4(1,:)=InitialDist5;



for j=1:numel(score_struc(1,:))
    for i=1:numel(score_struc(:,1))
        %for m=1:numel(score_struc(1,1).model(1,:))
        med_struc(j+1).medF0(i)=median(score_struc(1,j).model(:,i))/NF_total(1);
        med_struc(j+1).medF1(i)=median(score_struc(2,j).model(:,i))/NF_total(2);
        med_struc(j+1).medF2(i)=median(score_struc(3,j).model(:,i))/NF_total(3);
        med_struc(j+1).medF3(i)=median(score_struc(4,j).model(:,i))/NF_total(4);
        med_struc(j+1).medF4(i)=median(score_struc(5,j).model(:,i))/NF_total(5);
    end
        med_struc(j+1).dataF0=score_struc(1,j).data/Data{1,j}.NF(1) ;
        med_struc(j+1).dataF1=score_struc(2,j).data/Data{1,j}.NF(2) ;
        med_struc(j+1).dataF2=score_struc(3,j).data/Data{1,j}.NF(3) ;
        med_struc(j+1).dataF3=score_struc(4,j).data/Data{1,j}.NF(4) ;
        med_struc(j+1).dataF4=score_struc(5,j).data/Data{1,j}.NF(5) ;
   
    % Remove NaN from dividing by zeros
    med_struc(j+1).dataF0(isnan(med_struc(j+1).dataF0))=0 ;
    med_struc(j+1).dataF1(isnan(med_struc(j+1).dataF1))=0 ;
    med_struc(j+1).dataF2(isnan(med_struc(j+1).dataF2))=0 ;
    med_struc(j+1).dataF3(isnan(med_struc(j+1).dataF3))=0 ;
    med_struc(j+1).dataF4(isnan(med_struc(j+1).dataF4))=0 ;
end
    
end