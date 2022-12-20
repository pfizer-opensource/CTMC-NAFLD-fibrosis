function Calculate_iterative_Change(sweep_var,var_struc_for,var_struc_back,Data,n)

    % Calculate the average change in fibrosis score assuming a large population     
    for i=1:numel(sweep_var)     
    P1P2.formed(i)=Change_Fib_Score(var_struc_for(i,:));
    [P1P2.backmed(i)]=Change_Fib_Score(var_struc_back(i,:));
    end
    
    %  Calculate Statistics for change in average fibrosis score
    for k=1:numel(var_struc_for(:,1))
    [p1_SD(:,k),~,p1_avg(:,k)]=Change_Fib_ScoreRSD(var_struc_for(k,:));
    [p2_SD(:,k),~,p2_avg(:,k)]=Change_Fib_ScoreRSD(var_struc_back(k,:));
    end
 
    % Calclulate change in fibrosis score compared to placebo
    load('Save_Results1','log_p','final_parameters')
    var_flag =0; % Placebo parameters
    [score_struc_placebo, ~]=simdataGenN(final_parameters,Data,var_flag);
    
    for j=1:4
    Delta_placebo.for(j)=Change_Fib_Score(score_struc_placebo); 
    end
    
    % SD values to plot
    P1_Delta=P1P2.formed- Delta_placebo.for(1) ;
    p1_top_SD=P1_Delta + p1_SD ;
    p1_low_SD=P1_Delta - p1_SD ;
    P2_Delta=P1P2.backmed- Delta_placebo.for(1);
    p2_top_SD=P2_Delta + p2_SD ;
    p2_low_SD=P2_Delta - p2_SD ;

%% Plots

y=zeros(1,length(sweep_var));
%Parameters 1 and 2  
    figure;
    subplot(2,1,1)
    semilogx(sweep_var,P1_Delta,'k','LineWidth',2)
    hold on
    semilogx(sweep_var,p1_top_SD,'r:','LineWidth',2)
    hold on
    semilogx(sweep_var,p1_low_SD,'r:','LineWidth',2)
    hold on
    semilogx(sweep_var,y,'--','color','k')
        if n == 1
        title('p_1 : F0 -> F1')
        elseif n == 2
        title('p_3 : F1 -> F2')
        elseif n == 3
        title('p_5 : F2 -> F3')
        elseif n == 4
        title('p_7 : F3 -> F4')
        end 
            
    xlabel('Parameter Fold Change')
    ylabel({'\Delta F 24 months';'(pbo subtracted)'})
    set(gca,'FontSize', 18)
    legend('show')
    h1=legend('Average','SEM');
    h1.Location='northwest';
    h1.FontSize=12;
    ylim([-.5,1]);
    xlim([0.001  100]);
    
    subplot(2,1,2)
    semilogx(sweep_var,P2_Delta,'k','LineWidth',2)
    hold on
    semilogx(sweep_var,p2_top_SD,'r:','LineWidth',2)
    hold on
    semilogx(sweep_var,p2_low_SD,'r:','LineWidth',2)
    hold on
    semilogx(sweep_var,y,'--','color','k','LineWidth',1)
    
        if n == 1
        title('p_2 : F1 -> F0')
        elseif n == 2
        title('p_4 : F2 -> F1')
        elseif n == 3
        title('p_6 : F3 -> F2')
        elseif n == 4
        title('p_8 : F4 -> F3')
        end 

    xlabel('Parameter Fold Change')
    ylabel({'\Delta F 24 months'; '(pbo subtracted)'})
    set(gca,'FontSize', 18)
    %legend('show')
    %h2=legend('Average','SEM');
    %h2.Location='southwest';
    %h2.FontSize=12;
    ylim([-.5,1]); 
    xlim([0.001  100]);
    
    