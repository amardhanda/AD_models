clear all
% demented patients
load('demented');

%% declare variables - for model
data = demented(2,42,:); 
sntd_dev = 3.84;
final_decline = 2.74;

%distribution of data
%data = randi([0,30],1,data_lngth);

[average_path1,change1] = decline_simulation(data, sntd_dev,final_decline);
%[average_path2,change2] = deter_decline_simulation(data,final_decline);

[vector] = raw_preprocessing(demented);

%%
figure;

errorbar(vector(1,:),vector(2,:),vector(4,:)./sqrt(vector(3,:)),'Color',[0.9 0 0.1],'LineWidth',2);

hold on 
errorbar(average_path1(1,:),average_path1(2,:),average_path1(3,:)./sqrt(vector(3,:)),'Color',[0.1 0.1 0.5],'LineWidth',2);

hold on 
yline(0,'Color',[0.35 0.35 0.35],'LineWidth',1);

ylim([-5,5]);
set(gca, 'FontSize', 16)
title('Comparison of Clinical Data to Agent-Based Model', 'FontSize', 16);
ylabel('Cognitive Change (score/year)', 'FontSize', 16);
xlabel('Initial Score', 'FontSize', 16);
legend('Average Clinical Cogntive Change','Agent-Based Estimation');