function [score,NF_total] = scoreFibrosisModel_Gennan(log_p,baseline_parameters,Data)

%% Input definitions
% log_p parameters to score or plot
% baseline_parameters are initial parameters 
% T_final is study length in months

%% Simulation Parameters
% put the parameters back in normal scale
p=exp(log_p);

% Organizing time vector for input data, each data set is associated with a
% different study time

A=numel(Data);
Tvec=zeros(1,A);
N=zeros();
for i=1:A
Tvec(i)=Data{1,i}.T_end;
N(i)=Data{1,i}.N;
end

% Time of longest study - how long the model should run for (months)
T_end=Tvec(end);

%% Define the model
parameters=baseline_parameters;
parameters.markov.forward=p(1:2:8);
parameters.markov.backward=p(2:2:8);
parameters.progressor_probability=p(9);

var_flag=0;
[react_struc,Tvector,Y] = fibrosis_model_construct(parameters,5,T_end,var_flag);

%% Simulate the trial

InitialDist1=[1 0 0 0 0];
InitialDist2=[0 1 0 0 0];
InitialDist3=[0 0 1 0 0];
InitialDist4=[0 0 0 1 0];
InitialDist5=[0 0 0 0 1];


NF0=zeros();
InitialF0=zeros(A,5);
InitialF1=zeros(A,5);
InitialF2=zeros(A,5);
InitialF3=zeros(A,5);
InitialF4=zeros(A,5);

NF0=zeros(1,A);
NF1=zeros(1,A);
NF2=zeros(1,A);
NF3=zeros(1,A);
NF4=zeros(1,A);

    for j=1:numel(Data)
        NF0(j)=Data{1,j}.NF(1);    
        InitialF0(j,:)=Data{1,j}.Initial(1,:)/NF0(j);

        NF1(j)=Data{1,j}.NF(2);
        InitialF1(j,:)=Data{1,j}.Initial(2,:)/NF1(j);

        NF2(j)=Data{1,j}.NF(3);
        InitialF2(j,:)=Data{1,j}.Initial(3,:)/NF2(j);

        NF3(j)=Data{1,j}.NF(4);
        InitialF3(j,:)=Data{1,j}.Initial(4,:)/NF3(j);

        NF4(j)=Data{1,j}.NF(5);
        InitialF4(j,:)=Data{1,j}.Initial(5,:)/NF4(j);

        %To remove NAN from results if NF==0
        InitialF0(isnan(InitialF0))=0;
        InitialF1(isnan(InitialF1))=0;
        InitialF2(isnan(InitialF2))=0;
        InitialF3(isnan(InitialF3))=0;
        InitialF4(isnan(InitialF4))=0;

    end

NF0_total=sum(NF0);
NF1_total=sum(NF1);
NF2_total=sum(NF2);
NF3_total=sum(NF3);
NF4_total=sum(NF4);

NF_total=[NF0_total; NF1_total; NF2_total; NF3_total; NF4_total;];

[count1]= run_fibrosis_model_popgen(NF0_total,InitialDist1,react_struc,T_end,Tvec,Tvector,Y);
[count2]= run_fibrosis_model_popgen(NF1_total,InitialDist2,react_struc,T_end,Tvec,Tvector,Y);
[count3]= run_fibrosis_model_popgen(NF2_total,InitialDist3,react_struc,T_end,Tvec,Tvector,Y);
[count4]= run_fibrosis_model_popgen(NF3_total,InitialDist4,react_struc,T_end,Tvec,Tvector,Y);
[count5]= run_fibrosis_model_popgen(NF4_total,InitialDist5,react_struc,T_end,Tvec,Tvector,Y);

%output total number of patients starting in each group
NF_total=[NF0_total; NF1_total; NF2_total; NF3_total; NF4_total;];
%% calculate sum of squared errrors

    for k=1:numel(Data)
        count11=cell2mat(count1(:,k));
        count22=cell2mat(count2(:,k));
        count33=cell2mat(count3(:,k));
        count44=cell2mat(count4(:,k));
        count55=cell2mat(count5(:,k));

        if NF4_total == 0
            NF4_total=1;
        end
        if NF3_total==0
            NF3_total=1;
        end
        if NF2_total==0
            NF2_total=1;
        end
        if NF1_total==0
            NF1_total=1;
        end
        if NF0_total==0
            NF0_total=1;
        end

        scoreV=(NF0(k)^0.5)*(count11/NF0_total-InitialF0(k,:)).^2+(NF1(k)^0.5)*(count22/NF1_total-InitialF1(k,:)).^2+...
        (NF2(k)^0.5)*(count33/NF2_total-InitialF2(k,:)).^2+(NF3(k)^0.5)*(count44/NF3_total-InitialF3(k,:)).^2+...
        (NF4(k)^0.5)*(count55/NF4_total-InitialF4(k,:)).^2;

        score=sum(scoreV);
    end

 score=sum(score);

end

