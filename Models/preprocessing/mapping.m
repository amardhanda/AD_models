close all

equiv = [6,9,10,11,12,12,13,14,14,15,15,16,17,18,19,20,21,22,24,25,26,27,27,28,29,29,30,30,30,30,30];

%% load dataset 
data = dhanda1{:,:};

%% Filter out invalid scores and give each a unique id
score = zeros(size(data,1),size(data,2)+1);
score(:,1:56) = data;

for i = 1 : length(data)
    score(i,57) = i;
end


score = score(score(:,56) <= 30 ,:);
score = score(score(:,56) >= 0 ,:);

%% map scores 
k = 0;
for i = 1 : size(score,1)
    for j = 0: 30
        if score(i,56) == j
               score(i,56)  = equiv(j+1);
            k = k+1;
        break;
        end
    end
end


%% update scores in orginal data vector
n = 1;

for i = 1: length(score)
    for j = n:length(data)
        if score(i,57) == j
            data(j,42) = score(i,56);
            n = j;
        end
    end
end
    
%%

data = data(data(:,42) <= 30 ,:);
data = data(data(:,42) >= 0 ,:);
 
