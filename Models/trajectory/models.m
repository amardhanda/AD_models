clear all
% demented patients
load('demented');

%% declare variables - for model
data = demented(2,42,:); 
sntd_dev = 5;
final_decline = 3;
% repear mat N times
n = 1;
temp = repmat(data,1,3,n);

 data = temp(1,1,:);
%distribution of data
%data = randi([0,30],1,data_lngth);

[average_path1,change1] = decline_simulation(data, sntd_dev,final_decline);
%[average_path2,change2] = deter_decline_simulation(data,final_decline);

[vector] = raw_preprocessing(demented);

%%
figure;
scatter(change1(1,:),change1(2,:),'filled','MarkerFaceColor',[0.1 0.1 0.5],'MarkerEdgeColor',[0.1 0.1 0.5],'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.4)


%% plot original
hold on 
plot(average_path1(1,:),average_path1(2,:)+average_path1(3,:),'Color',[0.9 0 0.1],'HandleVisibility','off');
hold on
plot(average_path1(1,:),average_path1(2,:)-average_path1(3,:),'Color',[0.9 0 0.1],'HandleVisibility','off');
hold on
inBetween = [average_path1(2,:)+average_path1(3,:), flip(average_path1(2,:)-average_path1(3,:))];
x = [average_path1(1,:), flip(average_path1(1,:))];
fill(x, inBetween, 'r','facealpha',0.3,'edgecolor','none','HandleVisibility','off');

%%
plot(average_path1(1,:),average_path1(2,:),'Color',[0.9 0 0.1],'LineWidth',3);
%plot(average_path2(1,:),average_path2(2,:),'--','linewidth',2);

%%

hold on 
yline(0,'Color',[0.35 0.35 0.35],'LineWidth',1.5);

ylim([-30,30]);
set(gca, 'FontSize', 16)
title('Agent-Based Model', 'FontSize', 16);
ylabel('Cognitive Change (score/year)', 'FontSize', 16);
xlabel('Initial Score', 'FontSize', 16);
legend('Agent Cognitive Change','Average Agent Cognitive Change');