function Power_Calculations1(Weight,NMAX,T_end,fit_flag)
% Calculate the sample size necessary to run a clinical trial with the
% assuption that the weight is the weight of initial distribution
% population, Parameters are similar to pioglitazone intervention, T_end
% should be 18 months, otherwise model is extrapolating results from 18
% month

%% Power Calculations
% Generate Data Set

tic
    for h=1:50
        inew=1;
        for N=5:5:NMAX

            pio_flag=1;
            [Placebo_Data]=Calc_Boot(N,Weight,T_end,pio_flag) ;
            [Placebo_Data]=Read_in_data(Placebo_Data,T_end) ;
            [Placebo_Data]=Fit_Fibrosis_test(Placebo_Data) ;
            [Placebo_Datastore(h,:)]=(Placebo_Data);


            [Pio_Data]=Calc_Boot(N,Weight,T_end,pio_flag) ;
            [Pio_Data]=Read_in_data(Pio_Data,T_end);
            [Pio_Data]=Fit_Fibrosis_test(Pio_Data);
            [Pio_DataStore(h)]=(Pio_Data);

            Act_change=0; fit_flag=4; plot_flag=0; var_flag=2;
            [~,~,~,~,~,SD_Placebo,Score_Placebo]= Estimate_Alpha2('save_str',Placebo_Data,'Cusi_Placebo_Fit',0,4,0,2);%'Cusi_Placebo_Fit'
            [Struc_Pio,~,~,~,~,SD_Pio,Score_Pio]=Estimate_Alpha2('save_str',Pio_Data,'Cusi_Pio_Fit',0,4,0,2); %Cusi_Pio_Fit
            Placebo_Score(h,inew)=Score_Placebo ;
            Pio_Score(h,inew)=Score_Pio;
            Placebo_SD(h,inew)=SD_Placebo ;
            Pio_SD(h,inew)=SD_Pio;
            Struc_pio(h).struc(:,inew)=Struc_Pio ;

            inew=inew+1;

        end
    end
toc
save('POWER_Analysis')

%Calculate power and effect size for  each simulated trial
N=[5:5:NMAX];
    for i=1:h
        for M=1:numel(Pio_Score(1,:))
            pwrout(i,M)=sampsizepwr('t2',[Placebo_Score(i,M) Placebo_SD(i,M)],Pio_Score(i,M),[],N(M)) ;
            p1_out(i,M)=sampsizepwr('t2',[Placebo_Score(i,M) Placebo_SD(i,M)],[],0.8,N(M)); %
        end
    end

Effect_Size=Placebo_Score-p1_out;
ES=Effect_Size./Placebo_SD;

pwroutmean=mean(pwrout,1);
ESmean=mean(ES,1);
std_pwrout=std(pwrout,1);
std_ES=std(Effect_Size,1);

x=5:5:NMAX;
y=1:numel(x);
y(y)=0.8;

z=1:numel(x) ;
z(z)=-0.5 ;

%% Plot Power vs. Sample Size
figure;
plot(N,pwroutmean,'linewidth',2)
errorbar(N,pwroutmean,std_pwrout,'k','LineWidth',2)
title('Power Analysis')
xlabel('Sample Size (N)')
ylabel('Power')
set(gca,'FontSize',14)
hold on
plot(x,y,'--r','LineWidth',2)
h1=legend('Power +/- SD','0.8 Power');
h1.Location='southeast';
h1.FontSize=12;
ylim([0 1]);

end

