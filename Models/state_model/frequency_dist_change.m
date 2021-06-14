clear all

%% prepocessing for state-based model
load('mapped.mat');
load('demented.mat');


%%

a_points = [-1.5 , -1.5, 18.5, 18.5 ];
b_points = [18.5,18.5 ,24.5, 24.5 ];
c_points = [24.5,24.5, 31.5, 31.5];
points = [0 , 0.08, 0.08, 0];

%%
figure;
a = fill(a_points,points,[0.621 0.793 0.929]);
a.FaceAlpha = 0.3;
hold on 
b = fill(b_points,points,[0.39 0.59 0.746]);
b.FaceAlpha = 0.3;
hold on
c = fill(c_points,points,[0.9 0 0.1]);
c.FaceAlpha = 0.3;

hold on 
histogram(demented(1,42,:),'Normalization','probability','FaceColor',[0.1 0.1 0.5]);

xline(18.5,'LineWidth',2);
xline(24.5,'LineWidth',2);

xlim([-1.5,31.5]);

set(gca, 'FontSize', 16)
title('Initial Frequency distribution of Score', 'FontSize', 16);
ylabel('Probability', 'FontSize', 16);
xlabel('Score', 'FontSize', 16);

%%
sntd_dev = 3.84;
mean_decline = 2.74;
step = 1;

sim_score = zeros(length(demented),1);

for i = 1: length(demented)
    temp = (demented(3,4,i) + demented(3,3,i)/12);
    while temp > 0
        if temp >= step
            decline = (sntd_dev*randn(1) - mean_decline)*step ;
            sim_score(i) = demented(1,42,i) + decline;
            else  
            decline = (sntd_dev*randn(1) - mean_decline) * temp;
            sim_score(i) = demented(1,42,i) + decline; 
        end

        %working with limits 
        if (sim_score(i)  >= 30)
            sim_score(i)  = 30;
        elseif (sim_score(i)  <= 0)
            sim_score(i)  = 0;
        end
        temp = temp - step;
    end
end

sim_score = round(sim_score)



%%
subplot(1,2,1)
histogram(demented(2,42,:),'Normalization','probability','FaceColor',[0.1 0.1 0.5]);

hold on
histogram(sim_score(:),'Normalization','probability','FaceColor',[0.9 0 0.1]);
hold on
xline(18.5,'LineWidth',2);
xline(24.5,'LineWidth',2);
hold off

xlim([-1.5,31.5]);
ylim([0,0.08]);

set(gca, 'FontSize', 16)
title('Posterior Score Distribution, step size = 1', 'FontSize', 16);
ylabel('Probability', 'FontSize', 16);
xlabel('Score', 'FontSize', 16);
legend('Clincal Data','Simulated Data');

%%
sntd_dev = 3.84;
mean_decline = 2.74;
step = 1.25;

sim_score = zeros(length(demented),1);
for i = 1: length(demented)
    temp = (demented(3,4,i) + demented(3,3,i)/12);
    while temp > 0
        if temp >= step
            decline = (sntd_dev*randn(1) - mean_decline)*step ;
            sim_score(i) = demented(1,42,i) + decline;
            else  
            decline = (sntd_dev*randn(1) - mean_decline) * temp;
            sim_score(i) = demented(1,42,i) + decline; 
        end
        %working with limits 
        if (sim_score(i)  >= 30)
            sim_score(i)  = 30;
        elseif (sim_score(i)  <= 0)
            sim_score(i)  = 0;
        end
        temp = temp - step;
    end
end

sim_score = round(sim_score)



%%
subplot(1,2,2)
histogram(demented(2,42,:),'Normalization','probability','FaceColor',[0.1 0.1 0.5]);

hold on
histogram(sim_score(:),'Normalization','probability','FaceColor',[0.9 0 0.1]);
hold on
xline(18.5,'LineWidth',2);
xline(24.5,'LineWidth',2);
hold off

xlim([-1.5,31.5]);
ylim([0,0.08]);

set(gca, 'FontSize', 16)
title('Posterior Score Distribution, step size = 1.25', 'FontSize', 16);
ylabel('Probability', 'FontSize', 16);
xlabel('Score', 'FontSize', 16);
legend('Clincal Data','Simulated Data');


