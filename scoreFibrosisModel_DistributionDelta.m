function [score] = scoreFibrosisModel_DistributionDelta(log_p,baseline_parameters,Actual_Change,Data,Data2)

%% Input definitions
% logp parameters to score or plot
% baseline_parameters initial parameters (written over)
% T_final is study length in months

%% simulation parameters
% put the parameters back in normal scale
p=exp(log_p);

%Organizing Time vector for input data, each data set is associated with a
%different study time
A=numel(Data);
Tvec=zeros(1,A);
N=zeros();
for i=1:A
    Tvec(i)=Data{1,i}.T_end;
    N(i)=Data{1,i}.N;
end

% Time of longest study - how long the model should run for
T_end=Tvec(end);
% number of patients total in the study population
NF=sum(N);


%% define the model
parameters=baseline_parameters;
parameters.markov.forward=p(1:2:8);
parameters.markov.backward=p(2:2:8);
parameters.progressor_probability=p(9);
parameters.alpha=p(10:1:17);

var_flag=1; % Pioglitazone parameters
[react_struc,Tvector,Y] = fibrosis_model_construct(parameters,5,T_end,var_flag);


%% simulate the trial
% N is the total number of participants in all data sets

for h=1:A
    
    N(h)=Data{1,h}.N;
    InitialDist(h,:)=Data{1,h}.Initial/N(h);
    [count1]= run_fibrosis_model_popgen(NF,InitialDist(h,:),react_struc,T_end,Tvec,Tvector,Y);
end
%% Delta Fibrosis Score

for h=1:A
    [table1]= run_fibrosis_model_popgen(Data{1,h}.Initial(1),[1 0 0 0 0],react_struc,T_end,Tvec,Tvector,Y);
    [table2]= run_fibrosis_model_popgen(Data{1,h}.Initial(2),[0 1 0 0 0],react_struc,T_end,Tvec,Tvector,Y);
    [table3]= run_fibrosis_model_popgen(Data{1,h}.Initial(3),[0 0 1 0 0],react_struc,T_end,Tvec,Tvector,Y);
    [table4]= run_fibrosis_model_popgen(Data{1,h}.Initial(4),[0 0 0 1 0],react_struc,T_end,Tvec,Tvector,Y);
    [table5]= run_fibrosis_model_popgen(Data{1,h}.Initial(5),[0 0 0 0 1],react_struc,T_end,Tvec,Tvector,Y);
    
    [score_struc]=ScorestructureGenN(table1,table2,table3,table4,table5,Data2,N);
    
    [~,SD,Change_in_score]=Change_Fib_ScoreRSD(score_struc);
end



%% calculate sum of squared errrors

for k=1:numel(Data)
    count11=cell2mat(count1(:,k));
    
    NF_Final=Data{1,k}.NF/(sum(Data{1,k}.NF));
    
    scoreV=(N(k)^0.5)*(count11/NF-NF_Final).^2+...
        (4*(Change_in_score-Actual_Change).^2)+(2*(SD-1.2).^2);
    
    score(k)=sum(scoreV);
end

score=sum(score);

end
