function [Data]=Calc_Boot(N,weight,T_end,pio_flag)
    
% Pio_flag = 1 for pioglitazone distributions
    if pio_flag==1
    % Generate a new data set for model simulation by sampling from the
    % weighted distribution
    stage=[1 2 3 4 5] ;

    [F0]=datasample(stage,N,'weights',weight); 
    [A,B]=hist(F0,stage) ;
    [Data]=diag(A(B)) ;
    else

    % Generates a new data set for model simulation by sampling from the
    % weighted distribution
    %
    % Initial Proportions estimated from total 225 patients:
    % F0 = 0.37
    % F1 = 0.36
    % F2 = 0.19
    % F3 = 0.07
    % F4 = 0.01
    % Estimate N number of patients in for each initial stage

    % This assumption only holds true if study patient inclusion criteria is the
    % same

    NF0=round(N*0.37) ;
    NF1=round(N*0.36) ;
    NF2=round(N*0.19) ;
    NF3=round(N*0.07) ;
    NF4=round(N*0.01) ;
    stage=[1 2 3 4 5] ;


    [F0]=datasample(stage,NF0,'weights',weight(1,:)); 
    [A,B]=hist(F0,stage) ;
    [F0]=A(B) ;
    [F1]=datasample(stage,NF1, 'weights',weight(2,:));
    [A,B]=hist(F1,stage) ;
    [F1]=A(B) ;
    [F2]=datasample(stage,NF2, 'weights',weight(3,:));
    [A,B]=hist(F2,stage) ;
    [F2]=A(B) ;
    [F3]=datasample(stage,NF3, 'weights',weight(4,:));
    [A,B]=hist(F3,stage) ;
    [F3]=A(B) ;


    %Reconstruct Data Table with removed F4 starters
    Data_Table=[F0; F1; F2; F3;[0 0 0 0 0]] ;

    [Data]=Read_in_data(Data_Table,T_end);
    end 

end