function [Data_Set]=Read_in_dataDist(InitialDist, FinalDist,T_final)
%Read in initial and final distributions 


NF0=FinalDist(1);
NF1=FinalDist(2);
NF2=FinalDist(3);
NF3=FinalDist(4);
NF4=FinalDist(5);
N=sum(InitialDist);
Dist=InitialDist;

Data_Set=struct;
Data_Set(1).NF=[NF0,NF1,NF2,NF3,NF4];
Data_Set(1).Initial= Dist;
Data_Set(1).T_end=T_final;
Data_Set(1).N=N;
end