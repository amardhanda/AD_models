clear all
close all
%% decay demented with time
load('demented');

vec_avg = zeros(6,max(demented(1,42,:)+1));

for i= 1: max(demented(1,42,:))+1
    vec_avg(1,i) = i - 1; 
    for k = 1: size(demented(:,42,:),3)
        if demented(1,42,k) == i - 1
            vec_avg(2,i) = vec_avg(2,i) + demented(3,42,k);
            vec_avg(3, i)= vec_avg(3, i) +1;
        end
    end
end

vec_avg(2,:) = vec_avg(2,:)./ vec_avg(3,:);

for i = 1: max(vec_avg(1,:))+1
    temp = sum(demented(1,42,:) == i - 1);
    temp_vec = zeros(temp,1);
    temp = 1;
    for j= 1 : size(demented(:,42,:),3)
        if  demented(1,42,j) == i - 1
            temp_vec(temp) = demented(3,42,j);
            temp = temp + 1;
        end
    end
    vec_avg(4,i) = std(temp_vec);
end

vec_avg(5,:) = vec_avg(2,:)+ vec_avg(4,:);
vec_avg(6,:) = vec_avg(2,:)- vec_avg(4,:);

vec = demented(3,42,:)./(demented(3,4,:)+demented(3,3,:)/12);
%%
figure;
scatter(demented(1,42,:),vec,'filled','MarkerFaceColor',[0.1 0.1 0.5],'MarkerEdgeColor',[0.1 0.1 0.5],'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.4)
hold on
plot(vec_avg(1,:),vec_avg(2,:),'Color',[0.9 0 0.1],'LineWidth',3);
hold on

plot(vec_avg(1,:),vec_avg(5,:),'Color',[0.9 0 0.1]);
hold on
plot(vec_avg(1,:),vec_avg(6,:),'Color',[0.9 0 0.1]);
hold on
inBetween = [vec_avg(5,:), flip(vec_avg(6,:))];
x = [vec_avg(1,:), flip(vec_avg(1,:))];
fill(x, inBetween, 'r','facealpha',0.3,'edgecolor','none');

hold on 
yline(0,'Color',[0.35 0.35 0.35],'LineWidth',1.5);


%yline(-2.5);

hold off;


ylim([-30,30]);
set(gca, 'FontSize', 16)
title('Cognitive Change - Clinical Data', 'FontSize', 16);
ylabel('Cognitive Change (score/year)', 'FontSize', 16);
xlabel('Initial Score', 'FontSize', 16);
legend('Participant Cognitive Change','Average Cognitive Change');


%%
