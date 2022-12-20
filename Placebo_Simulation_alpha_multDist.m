function Placebo_Simulation_alpha_multDist(Placebo_Weight,save_str,fig)

% This simulation function is to predict the number of patients that
% improve in fibrosis score of 1 or more
% Step 1: Generate a "typical trial population". Patient fibrosis scores
% are bootstrapped assuming weighting according to Cusi et al.
% Sources of variability: Initial distribution weighting, actual initial
% distribution, number of patients (abs. number vs. %)

    for i=1:1:10
        T_end = 12;
        NMAX = 100;
        for N=10:5:NMAX % Min to Max patients
            pio_flag=1; var_flag=1;
            [Placebo_Data]=Calc_Boot(N,Placebo_Weight,T_end,pio_flag) ;
            [Placebo_Data]=Read_in_data(Placebo_Data,T_end) ;
            [Placebo_Data]=Fit_Fibrosis_test(Placebo_Data) ;
            [Placebo_Datastore((N-5)/5,:)]=(Placebo_Data);
            load('Cusi_Alpha.mat','alpha_parameters')
            [score_struc_1,~,~]=simdataGenN(alpha_parameters,Placebo_Data,var_flag);%Simulates the outcome of trial with the same distribution 200 times
            Struc_deposit2((N-5)/5,:)=score_struc_1;

            [Avg_Change,SD_mean,Change_percent,SD_percent,percent_decline,percent_no_change,Average_Decline,Average_No_change] = Percent_Pop_Improved(score_struc_1);
            Avg_change_save((N-5)/5,:)=Avg_Change;%saves the average # of patients improved following simulation 500 x
            SD_mean_save((N-5)/5,:)=SD_mean;
            Change_percent_save((N-5)/5,:)= Change_percent;% Not averaged for 500 simulations
            SD_percent_save((N-5)/5,:)=SD_percent;

            percent_decline_save((N-5)/5,:)=percent_decline;
            percent_no_change_save((N-5)/5,:)=percent_no_change;
            Average_decline_save((N-5)/5,:)=Average_Decline;
            Average_no_change((N-5)/5,:)=Average_No_change;

        end

        for h=1:1:numel(Change_percent_save(1,:))
            total_percent_imp{i,h}=Change_percent_save(:,h);
            total_percent_decl{i,h}=percent_decline_save(:,h);
            total_per_nochange{i,h}=percent_no_change_save(:,h);
        end
    end

save(save_str,'Average_Decline','Average_No_change','Avg_Change');

percentimp=horzcat(total_percent_imp{:,:});
percentdecl=horzcat(total_percent_decl{:,:});
percent_nochange=horzcat(total_per_nochange{:,:});
struct.Data(i,:)=(Placebo_Datastore);



N=10:5:NMAX;
[meanpercent_improved2,percentile_imp,percentile]=percent_Stats(percentimp);
[meanpercent_decline,percentile_decl]=percent_Stats(percentdecl);
[meanpercent_nochange,percentile_nochange]=percent_Stats(percent_nochange);

    if fig==51
        figure;
        plot(N,meanpercent_improved2,'-k','LineWidth',2)
        errorbar(N,meanpercent_improved2,percentile_imp(1,:),percentile_imp(2,:))
        ylabel('Pts. with improved fibrosis (%)')
        xlabel('Number of Patients')
        set(gca,'FontSize',18)
        hold on
        plot([21],[33],'ro','MarkerSize',8,'MarkerFaceColor','r') % Belfort  et al. 6 mo.
        plot([30],[20],'bo','MarkerSize',8,'MarkerFaceColor','b') % Aithal et al. 12 mo.
        plot([51],[25],'mo','MarkerSize',8,'MarkerFaceColor','m') % Cusi et al.  18 mo.
        legend( '\mu  (5-95^t^h percentile error bars)','6 mo.','12 mo.','18 mo.')
        axis([0 110 0 50])
    elseif fig ==52
        figure;
        plot(N,meanpercent_improved2,'-k','LineWidth',2)
        errorbar(N,meanpercent_improved2,percentile_imp(1,:),percentile_imp(2,:))
        ylabel('Pts. with improved fibrosis (%)')
        xlabel('Number of Patients')
        set(gca,'FontSize',18)
        xlim([0 110]);ylim([0 50])
    end

end
