clear all
close all
%% decay vector with time

%set = load('/Users/amardhanda/Documents/MATLAB/AD/Variable decay/analysis of fact/mmse_one_sign');
set = load('/Users/amardhanda/Documents/MATLAB/AD/Variable decay/analysis of fact/moca_two_sign');
unnamed = set.unnamed1

%% Bootstrap CI
lngth = 1000;
sample = bootstrp(lngth,@mean,unnamed);



%%
figure;
[fi,xi] = ksdensity(sample);

temp = round(lngth*0.05);
sample = sortrows(sample);
sample(temp)

plot(xi,fi)
hold on
xline(sample(temp),'r','LineWidth',2);

x_points = [x, x , sample(temp) , sample(temp)];
y_points = [0 , y, y, 0];
a = fill(x_points,y_points,'r');
a.FaceAlpha = 0.1;
%xlim([-0.72,-0.64]);

title('MMSE distribution: One Disease Factor');
xlabel('Avearge cognitive decline','FontSize', 16);
set(gca, 'FontSize', 14);



