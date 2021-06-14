clear all
close all
%% prepocessing for state-based model
load('demented.mat');

%%
for i = 1 : size(demented,3)
    for j = 1:2
        if demented(j,42,i) >= 25
            demented(j,56,i) = 1;
        elseif demented(j,42,i) < 25 & demented(j,42,i) > 18 
            demented(j,56,i) = 2;
        elseif demented(j,42,i) <=18
            demented(j,56,i) = 3;
        end
    end
end

%% average years between visits
figure;

sum(demented(3,4,:)+demented(3,3,:)/12)/17943;
histogram(demented(3,4,:)+demented(3,3,:)/12,'Normalization','probability','FaceColor',[0.1 0.1 0.5]);

set(gca, 'FontSize', 16)
xlabel('Time between visits (years)');
ylabel('Probability');
title('Frequency of Time Between Visits');