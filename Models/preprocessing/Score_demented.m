%%close all

data = mapped_vector;

%% delete times less than 6 months
l1 = size(data,3);
for i = l1:-1:1
    if (data(3,4,i)+data(3,3,i)/12 <= 0.5)
        data(:,:,i) = [];
    end
end

%%
l1 = size(data,3);
demented = zeros(3,56,sum(data(1,45,:) == 1));

%%
j = 1;

for i = 1:l1
    if data(1,45,i) == 1
        demented(:,:,j) = data(:,:,i);
        j=j+1;
    end
end