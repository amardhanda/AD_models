clear all
close all
%% decay vector with time
mmse = load('/Users/amardhanda/Documents/MATLAB/AD/MoCA_mapped_MMSE/disease_mapped');

vec_scr = mmse.vector;
mmse = load('/Users/amardhanda/Documents/MATLAB/AD/MoCA_mapped_MMSE/norma_mapped');
 vec_scr2 = mmse.vector;

disease_factors  = [9,13,15,16,17,19,21,27,48];

number_factors = 3;
test = 42; % 42 for MMSE /  56 for MoCA
x = -2.2;
y = 15;

l1 = size(vec_scr,3);
for i = l1:-1:1
    if (vec_scr(3,4,i)+vec_scr(3,3,i)/12 <= 0.5)
        vec_scr(:,:,i) = [];
    end
end

l1 = size(vec_scr2,3);
for i = l1:-1:1
    if (vec_scr2(3,4,i)+vec_scr2(3,3,i)/12 <= 0.5)
        vec_scr2(:,:,i) = [];
    end
end

%% Count nuber of unique 
dis_fact = zeros(length(vec_scr),13);
norm_fact = zeros(length(vec_scr2),13);
% diseased 
for i = 1 : length(vec_scr)
    for j = 1: length(disease_factors)
        dis_fact(i,j) = vec_scr(1,disease_factors(j),i);
    end
    dis_fact(i,10) = vec_scr(1,10,i);
    dis_fact(i,11) = vec_scr(1,33,i);
    dis_fact(i,12) = vec_scr(1,34,i);
end

for i = 1:length(dis_fact)
    dis_fact(i,13) = sum(dis_fact(i,:) == 1)+ sum(dis_fact(i,:) == 2);
    if dis_fact(i,10) > 5 & dis_fact(i,10) < 80
        dis_fact(i,13) = dis_fact(i,13) + 1;
    end
    if dis_fact(i,11)./dis_fact(i,12).^2 >= 0.0427
        dis_fact(i,13) = dis_fact(i,13) + 1;
    end
end
%normal 
% set new vector
for i = 1 : length(vec_scr2)
    for j = 1: length(disease_factors)
        norm_fact(i,j) = vec_scr2(1,disease_factors(j),i);
    end
    norm_fact(i,10) = vec_scr2(1,10,i);
    norm_fact(i,11) = vec_scr2(1,33,i);
    norm_fact(i,12) = vec_scr2(1,34,i);
end
% count
for i = 1:length(norm_fact)
    norm_fact(i,13) = sum(norm_fact(i,:) == 1)+ sum(norm_fact(i,:) == 2);
    if norm_fact(i,10) >5 & norm_fact(i,10) < 80
        norm_fact(i,13) = norm_fact(i,13) + 1;
    end
    if norm_fact(i,11)./norm_fact(i,12).^2 >= 0.0427
        norm_fact(i,13) = norm_fact(i,13) + 1;
    end
end

%% new vector
temp = sum(dis_fact(:,13) >= number_factors);
vec_scr_t = zeros(3,56,temp);

j = 1;
for i = 1:length(vec_scr)
    if  dis_fact(i,13) >= number_factors;
            vec_scr_t(:,:,j) = vec_scr(:,:,i);
            j = j+1;
    end
end

%%

temp = sum(norm_fact(:,13) >= number_factors);
vec_scr2_t = zeros(3,56,temp);

j = 1;
for i = 1:length(vec_scr2)
    if  norm_fact(i,13) >= number_factors;
            vec_scr2_t(:,:,j) = vec_scr2(:,:,i);
            j = j+1;
    end
end
%% Bootstrap CI
lngth = 1000;
time_dis_bt = bootstrp(lngth,@mean,vec_scr_t(3,4,:)) + bootstrp(lngth,@mean,vec_scr_t(3,3,:))/12;
scr_dis_bt = bootstrp(lngth,@mean,vec_scr_t(3,test,:));

time_dis_bt2 = bootstrp(lngth,@mean,vec_scr2_t(3,4,:)) + bootstrp(lngth,@mean,vec_scr2_t(3,3,:))/12;
scr_dis_bt2 = bootstrp(lngth,@mean,vec_scr2_t(3,test,:));

dis_bt = zeros(lngth,1);

for i = 1: lngth
    dis_bt(i) = scr_dis_bt(i)/time_dis_bt(i) - scr_dis_bt2(i)/time_dis_bt2(i) ;
end

%%
figure;
[fi,xi] = ksdensity(dis_bt);

temp = round(length(dis_bt)*0.05);
dis_bt = sortrows(dis_bt);
dis_bt(temp)

plot(xi,fi)
hold on
xline(dis_bt(temp),'r','LineWidth',2);

x_points = [x, x , dis_bt(temp) , dis_bt(temp)];
y_points = [0 , y, y, 0];
a = fill(x_points,y_points,'r');
a.FaceAlpha = 0.1;
%xlim([-0.72,-0.64]);

title('Distribution: One Disease Factor');
xlabel('Average cognitive decline','FontSize', 16);
set(gca, 'FontSize', 14);



%% Count nuber of unique 
dis_fact = zeros(length(vec_scr_t),13);
norm_fact = zeros(length(vec_scr2_t),13);
% diseased 
for i = 1 : length(vec_scr_t)
    for j = 1: length(disease_factors)
        dis_fact(i,j) = vec_scr_t(1,disease_factors(j),i);
    end
    dis_fact(i,10) = vec_scr_t(1,10,i);
    dis_fact(i,11) = vec_scr_t(1,33,i);
    dis_fact(i,12) = vec_scr_t(1,34,i);
end

for i = 1:length(dis_fact)
    dis_fact(i,13) = sum(dis_fact(i,:) == 1)+ sum(dis_fact(i,:) == 2);
    if ((dis_fact(i,10) > 5) && (dis_fact(i,10) < 80))
        dis_fact(i,13) = dis_fact(i,13) + 1;
    end
    if dis_fact(i,11)/dis_fact(i,12).^2 >= 0.0427
        dis_fact(i,13) = dis_fact(i,13) + 1;
    end
end
%normal 
% set new vector
for i = 1 : length(vec_scr2_t)
    for j = 1: length(disease_factors)
        norm_fact(i,j) = vec_scr2_t(1,disease_factors(j),i);
    end
    norm_fact(i,10) = vec_scr2_t(1,10,i);
    norm_fact(i,11) = vec_scr2_t(1,33,i);
    norm_fact(i,12) = vec_scr2_t(1,34,i);
end
% count
for i = 1:length(norm_fact)
    norm_fact(i,13) = sum(norm_fact(i,:) == 1)+ sum(norm_fact(i,:) == 2);
    if norm_fact(i,10) >5 && norm_fact(i,10) < 80
        norm_fact(i,13) = norm_fact(i,13) + 1;
    end
    if norm_fact(i,11)/norm_fact(i,12).^2 >= 0.0427
        norm_fact(i,13) = norm_fact(i,13) + 1;
    end
end