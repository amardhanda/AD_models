clear all
%% prepocessing for state-based model
load('demented.mat');

min = 0;
max = 5;
temp = sum((demented(3,4,:) + demented(3,3,:)/12) > min & (demented(3,4,:)+demented(3,3,:)/12) < max)
vector = zeros(3,56,temp);

for i = 1 : length(demented)
    if (demented(3,4,i)+demented(3,3,i)/12) >= min & (demented(3,4,i)+demented(3,3,i)/12) < max
       vector(:,:,i) =  demented(:,:,i);
    end
end

%% Heat map
heat = zeros(31);

for i = 1: length(vector)
   
    temp1 = vector(1,42,i) + 1;
    temp2 = vector(2,42,i) + 1;
    
    heat(temp1,temp2) = heat(temp1,temp2) + 1;
    
end

%heat = heat./sum(sum(heat));

n = 5;

conv_operatator = 1/n^2*ones(n);
heat = conv2(heat,conv_operatator);

figure;
imagesc(flip(heat));
xline(18.5,'w','LineWidth',2);
xline(24.5,'w','LineWidth',2);

yline(12.5,'w','LineWidth',2);
yline(7.5,'w','LineWidth',2);

set(gca, 'FontSize', 16)
title('Transition Mapping', 'FontSize', 16);
ylabel('Score After Transition', 'FontSize', 16);
xlabel('Initial Score', 'FontSize', 16);

% xlim([0,30]);
% ylim([0,30]);

yticklabels = 0:5:30;
yticks = linspace(1, size(heat, 1), numel(yticklabels));
set(gca, 'yTick', yticks, 'yTickLabel',  flipud(yticklabels(:)), 'Colormap',turbo)

c = colorbar;
caxis([0 100])
c.Label.String = 'Number of Participants';
