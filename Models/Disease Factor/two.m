uni = unique(unnamed1(:,1:2));

vec = zeros(length(uni),4);

vec(:,1) = uni;

for i = 1:length(unnamed1)
    for j = 1:size(vec,1)
        if unnamed1(i,1)  == vec(j,1) | unnamed1(i,2) == vec(j,1)
            vec(j,2) = vec(j,2) + 1;
            vec(j,3) = vec(j,3) + unnamed1(i,3);
        end
    end
end

vec(:,4) = vec(:,3)./vec(:,2);
%% expected 