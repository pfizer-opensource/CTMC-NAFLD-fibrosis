function figure5
fig=5; % figure flag 

%  All patients start at F0
Placebo_Weight= [1,0,0,0,0] ; 
Placebo_Simulation_alpha_multDist(Placebo_Weight,'results5a1',fig)

load('results5a1')
F0_per_Decl = Average_Decline ;
F0_nochange = Average_No_change;
F0_perimp = Avg_Change ;

%  All patients start at F1
Placebo_Weight= [0,1,0,0,0] ; 
Placebo_Simulation_alpha_multDist(Placebo_Weight,'results5a2',fig)
load('results5a2')
F1_perDecl = Average_Decline ;
F1_pernochange = Average_No_change;
F1_perimp = Avg_Change ;

%  All patients start at F2
Placebo_Weight= [0,0,1,0,0] ; 
Placebo_Simulation_alpha_multDist(Placebo_Weight,'results5a3',fig)
load('results5a3')
F2_perDecl = Average_Decline ;
F2_pernochange = Average_No_change;
F2_perimp = Avg_Change ;

%  All patients start at F3
Placebo_Weight= [0,0,0,1,0] ; 
Placebo_Simulation_alpha_multDist(Placebo_Weight,'results5a4',fig)
load('results5a4')
F3_perDecl = Average_Decline ;
F3_pernochange = Average_No_change;
F3_perimp = Avg_Change ;

 figure;
 X=[1 1 1; 2 2 2; 3 3 3; 4 4 4;];
 Y=[F0_per_Decl, F0_nochange, F0_perimp; F1_perDecl, F1_pernochange, F1_perimp; F2_perDecl, F2_pernochange, F2_perimp; F3_perDecl, F3_pernochange, F3_perimp;];
 ba=bar(X,Y,'stacked','FaceColor','flat');
 set(gca,'XTickLabel',{'F0','F1','F2','F3'}, 'FontSize',14);
 hold on
 ylabel('Percent (%)')
 lgd=legend('Percent Decline','Percent No Change', 'Percent Improved');
 lgd.Location='northoutside';
 xlabel('Fibrosis Stage')
 axis([ 0 5 0 120])

ba(1).FaceColor = [0.6350, 0.0780, 0.1840]; % RGB red [1 0 0]
ba(2).FaceColor = [ 0 0 0]; % RGB black
ba(3).FaceColor = [0.4660, 0.6740, 0.1880]; % RGB green