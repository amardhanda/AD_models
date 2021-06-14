close all
clear all
%%
colour = [;  0.61 0.79 0.93; 0.1 0.1 0.5; 0.9 0 0.1];

%% Transition probability 
N = 10;

T = [0.571,0.351,0.079; 0.1,0.52,0.38; 0.004,0.084,0.912];
T_error = [0.087,0.0227, 0.035];

start = [1,0,0];

likely = zeros(N+1,3,3);
likely(1,:,1) = start;
likely(1,:,2) = likely(1,:,1) + likely(1,:,1)* T_error(1);
likely(1,:,3) = likely(1,:,1) - likely(1,:,1)* T_error(1);

%%
for i = 2 : N+1
    likely(i,:,1) = likely(i-1,:,1)*T;
    for j = 1: 3
        likely(i,j,2) = likely(i,j,1) + likely(i,j,1)*((1 + T_error(j))^i - 1) ;
        likely(i,j,3) = likely(i,j,1) - likely(i,j,1)*((1 + T_error(j))^i - 1);
    end
end


steady = start * T;

for i = 1:1000
    
    steady = steady * T;
end

%%

figure;
for i = 1 : 3
   
    inBetween = [likely(:,i,2); flip(likely(:,i,3))];
    x = [0:1:N, flip(0:1:N)];
    fill(x, inBetween,colour(i,:),'facealpha',0.3,'edgecolor','none','HandleVisibility','off');

    
    hold on

    plot(0:1:N,likely(:,i,1),'Color',colour(i,:),'LineWidth',2.5);
    alpha(.9)
    hold on
    
    yline(steady(i),'k','LineWidth',1, 'HandleVisibility', 'off');
    hold on
    
end

set(gca, 'FontSize', 16)
title('10 Year Prediction starting from MCI', 'FontSize', 16);
ylabel('Probability', 'FontSize', 16);
xlabel('Years', 'FontSize', 16);
xlim([0,N]);
ylim([0,1]);

legend('MCI','M-AD','S-AD');


