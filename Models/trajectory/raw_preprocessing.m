function [vec_avg] = raw_preprocessing(raw_data)
    
    lngth = size(raw_data,3);
    
%% section disease factors patients
    raw_decline = zeros(3,57,lngth);
    
   raw_decline(:,1:56,:) = raw_data;
    raw_decline(3,57,:) = raw_decline(3,42,:)./(raw_decline(3,4,:)+raw_decline(3,3,:)/12);
   
    %% vector disease
    
   vec_scr = raw_data;

            
    vec_avg = zeros(6,max(vec_scr(1,42,:)+1));

    for i= 1: max(vec_scr(1,42,:))+1
        vec_avg(1,i) = i - 1; 
        for k = 1: size(vec_scr(:,42,:),3)
            if vec_scr(1,42,k) == i - 1
                vec_avg(2,i) = vec_avg(2,i) + vec_scr(3,42,k);
                vec_avg(3, i)= vec_avg(3, i) +1;
            end
        end
    end

    vec_avg(2,:) = vec_avg(2,:)./ vec_avg(3,:);

    for i = 1: max(vec_avg(1,:))+1
        temp = sum(vec_scr(1,42,:) == i - 1);
        temp_vec = zeros(temp,1);
        temp = 1;
        for j= 1 : size(vec_scr(:,42,:),3)
            if  vec_scr(1,42,j) == i - 1
                temp_vec(temp) = vec_scr(3,42,j);
                temp = temp + 1;
            end
        end
        vec_avg(4,i) = std(temp_vec);
    end

    vec_avg(5,:) = vec_avg(2,:)+ vec_avg(4,:);
    vec_avg(6,:) = vec_avg(2,:)- vec_avg(4,:);
    
 end