clear all 

%% transition matrix
tp = zeros(5,3,3);

tp(1,:,:) = [0.59, 0.37, 0.04; 0.11, 0.57, 0.32; 0.00, 0.1,0.9];
tp(2,:,:) = [0.584, 0.343, 0.073; 0.10, 0.52, 0.38; 0.004, 0.086, 0.91];
tp(3,:,:) = [0.49, 0.36, 0.15; 0.10, 0.41, 0.49; 0.01, 0.06, 0.93];
tp(4,:,:) = [0.38, 0.39, 0.23; 0.08, 0.36, 0.56; 0.01, 0.06, 0.93];
tp(5,:,:) = [0.57,0.35,0.08;0.1,0.52,0.38;0.004,0.084,0.912];

%% states likelihoods

state = zeros(4,3);

state(1,:) = [0.3,0.42,0.28];
state(2,:) = [0.34,0.41,0.25];
state(3,:) = [0.32,0.42,0.26];
state(4,:) = [0.37,0.39,0.24];
%% transition labels

name = categorical([ "MCI -> MCI","MCI -> M-AD", "MCI -> S-AD","M-AD -> MCI", "M-AD -> M-AD", "M-AD -> S-AD",  "S-AD -> MCI", "S-AD -> M-AD", "S-AD -> S-AD"]);
                    
                        
name = reordercats(name,string(name));
%% error bar

err = zeros(9,1);
count = 0;
for i = 1 : 3
    for j = 1 : 3
        count = count +1;
        err(count) = std(tp(1:4,i,j));
    end
end

err =err/2

%%

vec = reshape(squeeze(tp(5,:,:))',1,[])
figure;
bar(name,vec,0.8,'FaceColor',[0.35 0.35 0.35],'EdgeColor',[0.35 0.35 0.35]);               
hold on

er = errorbar(vec,err,'LineStyle','none','LineWidth',2);  

er.MarkerSize = 10;
er.Color = [0.9 0 0.1];

 set(gca, 'FontSize', 16)
    title('Transition Probabilities of Dataset', 'FontSize', 16);
    ylabel('Probability', 'FontSize', 16);
    xlabel('Transitions', 'FontSize', 16);
    ylim([0,1]);