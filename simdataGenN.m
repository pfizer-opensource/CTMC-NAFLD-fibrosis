function [score_struc,NF_total,react_struc]=simdataGenN(final_parameters,Data,var_flag)
% var_flag = 0 is for placebo parameters
% var_flag = 1 is forward parameter fitting (alpha parameters)
% var_flag = 2 is forward  and reverse parameter fitting (beta parameters)

% Organizing Time vector for input data, each data set is associated with a
% different study time
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
N=sum(N);
IC=5; % Number of initial conditions - used only in ODE example
%% Define the model
[react_struc,Tvector,Y] = fibrosis_model_construct(final_parameters,IC,T_end,var_flag);
%% simulate the trial

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

% Simulate each distribution 500 times with the same number of initial
% starters in each population
    for k=1:500

        [table1(k,:)]= run_fibrosis_model_popgen(NF0_total,InitialDist1,react_struc,T_end,Tvec,Tvector,Y);
        [table2(k,:)]= run_fibrosis_model_popgen(NF1_total,InitialDist2,react_struc,T_end,Tvec,Tvector,Y);
        [table3(k,:)]= run_fibrosis_model_popgen(NF2_total,InitialDist3,react_struc,T_end,Tvec,Tvector,Y);
        [table4(k,:)]= run_fibrosis_model_popgen(NF3_total,InitialDist4,react_struc,T_end,Tvec,Tvector,Y);
        [table5(k,:)]= run_fibrosis_model_popgen(NF4_total,InitialDist5,react_struc,T_end,Tvec,Tvector,Y);
    end

[score_struc]=ScorestructureGenN(table1,table2,table3,table4,table5,Data,NF_total);

end
