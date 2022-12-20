function [score_struc]=ScorestructureGenN(table1,table2,table3,table4,table5,Data,NF_total)
% Generalized score structure function
% Table 1 is F0 starters over time where Tout is Tvec

table1=cell2mat(table1);
table2=cell2mat(table2);
table3=cell2mat(table3);
table4=cell2mat(table4);
table5=cell2mat(table5);

% build a structure to store the data and results
score_struc=struct;

A=numel(Data);

    for i=1:A
        j=i*5;
        k=j-4;

        score_struc(1,i).model=table1(:,k:j);
        score_struc(1,i).data=Data{i}.Initial(1,:);

        score_struc(2,i).model=table2(:,k:j);
        score_struc(2,i).data=Data{i}.Initial(2,:);

        score_struc(3,i).model=table3(:,k:j);
        score_struc(3,i).data=Data{i}.Initial(3,:);

        score_struc(4,i).model=table4(:,k:j);
        score_struc(4,i).data=Data{i}.Initial(4,:);

        score_struc(5,i).model=table5(:,k:j);
        score_struc(5,i).data=Data{i}.Initial(5,:);

        score_struc(1,i).data(isnan(score_struc(1,i).data))=0 ;
        score_struc(2,i).data(isnan(score_struc(2,i).data))=0 ;
        score_struc(3,i).data(isnan(score_struc(3,i).data))=0 ;
        score_struc(4,i).data(isnan(score_struc(4,i).data))=0 ;
        score_struc(5,i).data(isnan(score_struc(5,i).data))=0 ;

        score_struc(1,i).model(isnan(score_struc(1,i).model))=0 ;
        score_struc(2,i).model(isnan(score_struc(2,i).model))=0 ;
        score_struc(3,i).model(isnan(score_struc(3,i).model))=0 ;
        score_struc(4,i).model(isnan(score_struc(4,i).model))=0 ;
        score_struc(5,i).model(isnan(score_struc(5,i).model))=0 ;


    end

end