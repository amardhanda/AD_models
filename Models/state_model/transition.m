clear all 

%% transition matrix
tp = zeros(4,3,3);

tp(1,:,:) = [0.59, 0.37, 0.04; 0.11, 0.57, 0.32; 0.00, 0.10,0.9];
tp(2,:,:) = [0.58, 0.34, 0.07; 0.10, 0.52, 0.38; 0.00, 0.08, 0.91];
tp(3,:,:) = [0.47, 0.36, 0.14; 0.10, 0.41, 0.49; 0.01, 0.06, 0.93];
tp(4,:,:) = [0.38, 0.39, 0.23; 0.08, 0.36, 0.56; 0.01, 0.06, 0.93];
%tp(5,:,:) = [0.57,0.35,0.08;0.1,0.52,0.38;0.004,0.084,0.912];

%%
name = categorical([ "MCI -> MCI","MCI -> M-AD", "MCI -> S-AD","M-AD -> MCI", "M-AD -> M-AD", "M-AD -> S-AD",  "S-AD -> MCI", "S-AD -> M-AD", "S-AD -> S-AD"]);

                        
name = reordercats(name,string(name));
                    
colour = [0.35 0.35 0.35; 0.9 0 0.1; 0.1 0.1 0.5; 0.61 0.79 0.93];

%%
figure;
for i = 1 : 3

    b = bar(name(3*(i-1)+1 : 3*i),[tp(:,i,1)'; tp(:,i,2)';tp(:,i,3)']',0.8,'FaceColor','flat');
    hold on
    for j = 1: 4
        b(j).CData = colour(j,:);
%         xtips1 = b(j).XEndPoints;
%         ytips1 = b(j).YEndPoints;
%         labels1 = string(b(j).YData);
%         text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',14)
    end
end



lgd = legend({'0.5 - 1.0','1.0 - 1.5','1.5 - 2.0','2.0 - 2.5'});
title(lgd,'Years between Evaluations')    

    set(gca, 'FontSize', 16)
    title('Transition Probabilities between States ', 'FontSize', 16);
    ylabel('Probability', 'FontSize', 16);
    xlabel('Transitions', 'FontSize', 16);
    ylim([0,1]);