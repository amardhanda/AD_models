close all

%% load dataset 
data = dhanda1{:,:};

%% Filter out invalid scores
score = data(data(:,56) <= 30 ,:);
score = score(score(:,56) >= 0 ,:);

%% count number of unique entries 
uni_scr = zeros(height(unique(score(:,1))),2);
uni_scr(:,1) = unique(score(:,1),"stable");
l1 = height(uni_scr);
l2 = height(score);


for i =1:l2
    for j = 1:l1
        if score(i) == uni_scr(j)
            uni_scr(j,2) = uni_scr(j,2) + 1;
        end
    end
end

%% if count is 2 delete 

for i = l1:-1:1
 if uni_scr(i,2) >= 2
    uni_scr(i,:) = [];
 end
end

%% delet all unique scores
l1 = height(score);

for i = l1-1:-1:1
    for j = 1:height(uni_scr)
        if score(i,1) == uni_scr(j,1)
            score(i,:) = [];
        end
    end
 
end

%% count number of unique entries 
uni_scr = zeros(height(unique(score(:,1))),2);
uni_scr(:,1) = unique(score(:,1),"stable");
l1 = height(uni_scr);
l2 = height(score);


for i =1:l2
    for j = 1:l1
        if score(i) == uni_scr(j)
            uni_scr(j,2) = uni_scr(j,2) + 1;
        end
    end
end


%% 
equiv = [6,9,10,11,12,12,13,14,14,15,15,16,17,18,19,20,21,22,24,25,26,27,27,28,29,29,30,30,30,30,30];
%%

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

%% find vector size and create decay vector
temp = sum(uni_scr(:,2))- length(uni_scr);

vec_scr_moca = zeros(3,56,temp);

%% set each vector to the unique score
temp = 1;
for i = 1: length(score) - 1
    if score(i,1) == score(i+1,1)
       vec_scr_moca(1,:,temp) = score(i,:);
       vec_scr_moca(2,:,temp) = score(i+1,:);
       temp = temp+1;
    end
end

vec_scr_moca(3,:,:) = vec_scr_moca(2,:,:) - vec_scr_moca(1,:,:);

%% setting Moca column to moca equiv

vec_scr_moca(:,42,:) =  vec_scr_moca(:,56,:);

%% Filter out invalid scores
score = data(data(:,42) <= 30 ,:);
score = score(score(:,42) >= 0 ,:);

%% count number of unique entries 
uni_scr = zeros(height(unique(score(:,1))),2);
uni_scr(:,1) = unique(score(:,1),"stable");
l1 = height(uni_scr);
l2 = height(score);


for i =1:l2
    for j = 1:l1
        if score(i) == uni_scr(j)
            uni_scr(j,2) = uni_scr(j,2) + 1;
        end
    end
end

%% if count is 2 delete 

for i = l1:-1:1
 if uni_scr(i,2) >= 2
    uni_scr(i,:) = [];
 end
end

%% delet all unique scores
l1 = height(score);

for i = l1:-1:1
    for j = 1:height(uni_scr)
        if score(i,1) == uni_scr(j,1)
            score(i,:) = [];
        end
    end
end

%% count number of unique entries 
uni_scr = zeros(height(unique(score(:,1))),2);
uni_scr(:,1) = unique(score(:,1),"stable");
l1 = height(uni_scr);
l2 = height(score);


for i =1:l2
    for j = 1:l1
        if score(i) == uni_scr(j)
            uni_scr(j,2) = uni_scr(j,2) + 1;
        end
    end
end

%% find vector size and create decay vector
temp = sum(uni_scr(:,2))- length(uni_scr);

vec_scr = zeros(3,56,temp);

%% set each vector to the unique score
temp = 1;
for i = 1: length(score) - 1
    if score(i,1) == score(i+1,1)
       vec_scr(1,:,temp) = score(i,:);
       vec_scr(2,:,temp) = score(i+1,:);
       temp = temp+1;
    end
end

vec_scr(3,:,:) = vec_scr(2,:,:) - vec_scr(1,:,:);

%%
mapped_vector = cat(3,vec_scr_moca,vec_scr);