%load('demented_variance');
load('demented');

%% find average score change and time vector
chng_scr = zeros(2,size(demented,3));

for i = 1:size(demented,3)
    chng_scr(1,i) = demented(3,4,i) + demented(3,3,i)/12;
    chng_scr(2,i) = demented(3,42,i)/chng_scr(1,i);
end

%%
binEdges = 0:10;
bins = {'1','2','3','4','5','6','7','8','9','10'};
groupAge = discretize(chng_scr(1,:),binEdges,'categorical',bins);
figure; 
subplot(1,2,1)
boxchart(groupAge,chng_scr(2,:))
hold on 
yline( 0,'LineWidth',1);
ylim([-40,40])

title('Variance of Cognitive Change (Filtered)');
xlabel('Time between Evaluations (years)','FontSize', 16)
ylabel('Cognitive Change (points/year)','FontSize', 16)
set(gca, 'FontSize', 14)


subplot(1,2,2)
yline( 0,'LineWidth',1);
hold on 
boxplot(chng_scr(2,:));
hold off 

xlabel('Full Dataset','FontSize', 16)
set(gca, 'FontSize', 14)
ylim([-40,40])
