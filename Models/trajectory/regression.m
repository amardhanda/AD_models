%% Regression
load('av_cog_change.mat');
load('agent_model.mat');

%%
figure;
    subplot(1,2,1);
N = 6;

error = zeros(N,1);
plot(vec_avg(1,:), vec_avg(2,:), 'b.', 'MarkerSize', 15); % Plot training data.
hold on;

for i = 1: N
    coefficients = polyfit(vec_avg(1,:), vec_avg(2,:), i);
    % Create a new x axis with exactly 1000 points (or whatever you want).
    xFit = linspace(min(vec_avg(1,:)), max(vec_avg(1,:)), 930);
    % Get the estimated yFit value for each of those 1000 new x locations.
    yFit = polyval(coefficients , xFit);
    
    temp = 0;
    % Calculate Error
    for j = 1 : 31
        t = j+ 30*(j-1);
        if t == 931
            t = 930;
        end
        
        temp = temp + (vec_avg(2,j) - yFit(t))^2;
        
    end
    
    error(i) = sqrt(temp/31);
    
    % Plot curve.    
     % Set hold on so the next plot does not blow away the one we just drew.
    plot(xFit, yFit, 'LineWidth', 2); % Plot fitted line.
    hold on

end
ylim([-4 4]);
    set(gca, 'FontSize', 16)
    lgd = legend('Original Data','Order 1','Order 2','Order 3','Order 4','Order 5','Order 6 ');
    title(lgd,'Model Order')
    title('Regression Curves ', 'FontSize', 16);
    ylabel('Cognitive Change', 'FontSize', 16);
    xlabel('Initial Score', 'FontSize', 16);
    

hold off

subplot(1,2,2);
    stem(1:N,error);
    ylim([0 1]);
    title('Regression Curves Error ', 'FontSize', 16);
    set(gca, 'FontSize', 16)
    ylabel('RMSE', 'FontSize', 16);
    xlabel('Order', 'FontSize', 16);
    
    
    %%
    figure;
    subplot(1,2,1);
    error = zeros(N,1);
plot(average_path1(1,:), average_path1(2,:), 'b.', 'MarkerSize', 15); % Plot training data.
hold on;

for i = 1: N
    coefficients = polyfit(average_path1(1,:), average_path1(2,:), i);
    % Create a new x axis with exactly 1000 points (or whatever you want).
    xFit = linspace(min(average_path1(1,:)), max(average_path1(1,:)), 930);
    % Get the estimated yFit value for each of those 1000 new x locations.
    yFit = polyval(coefficients , xFit);
    
    temp = 0;
    % Calculate Error
    for j = 1 : 31
        t = j+ 30*(j-1);
        if t == 931
            t = 930;
        end
        
        temp = temp + (average_path1(2,j) - yFit(t))^2;
        
    end
    
    error(i) = sqrt(temp/31);
    
    % Plot curve.    
     % Set hold on so the next plot does not blow away the one we just drew.
    plot(xFit, yFit, 'LineWidth', 2); % Plot fitted line.
    hold on

end
ylim([-4 4]);
    set(gca, 'FontSize', 16)
    lgd = legend('Original Data','Order 1','Order 2','Order 3','Order 4','Order 5','Order 6 ');
    title(lgd,'Model Order')
    title('Regression Curves ', 'FontSize', 16);
    ylabel('Cognitive Change', 'FontSize', 16);
    xlabel('Initial Score', 'FontSize', 16);
    

hold off

subplot(1,2,2);
    stem(1:N,error);

    ylim([0 1]);
    title('Regression Curves Error ', 'FontSize', 16);
    set(gca, 'FontSize', 16)
    ylabel('RMSE', 'FontSize', 16);
    xlabel('Order', 'FontSize', 16);
