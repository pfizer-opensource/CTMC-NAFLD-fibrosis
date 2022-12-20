function [Data_Set]=Read_in_data(Data_Table,T_final)
% For a given study, the data table should consist of a table 5X5 (F0,
% F1,F2,F3,F4) This data is then read to generate how many patients started
% in each category and the final distribution for a given length of time.


NF0=sum(Data_Table(1,:));
Dist1=[1 0 0 0 0];
InitialF0=(Data_Table(1,:));

NF1=sum(Data_Table(2,:));
Dist2=[0 1 0 0 0];
InitialF1=(Data_Table(2,:));

NF2=sum(Data_Table(3,:));
Dist3=[0 0 1 0 0];
InitialF2=(Data_Table(3,:));

NF3=sum(Data_Table(4,:));
Dist4=[0 0 0 1 0];
InitialF3=(Data_Table(4,:));

NF4=sum(Data_Table(5,:));
Dist5=[0 0 0 0 1];
InitialF4=(Data_Table(5,:));

N=NF0+NF1+NF2+NF3+NF4;

Data_Set=struct;
Data_Set(1).NF=[NF0, NF1,NF2,NF3,NF4];
Data_Set(1).Dist= [Dist1; Dist2; Dist3; Dist4; Dist5;];
Data_Set(1).Initial=[InitialF0; InitialF1; InitialF2; InitialF3; InitialF4;];
Data_Set(1).T_end=T_final;
Data_Set(1).N=N;
end