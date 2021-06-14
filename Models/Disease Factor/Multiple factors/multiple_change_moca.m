%mmse = load('/Users/amardhanda/Documents/MATLAB/AD/Equiv Variable decay/MoCA/normal_moca');
mmse = load('/Users/amardhanda/Documents/MATLAB/AD/Equiv Variable decay/MoCA/disease_moca');

%% filter out min 6 months since 
vec_scr = mmse.vector;

disease_factors  = [9,13,15,16,17,19,21,27,48];

%% filter out min 6 months since 

l1 = size(vec_scr,3);
for i = l1:-1:1
    if (vec_scr(3,4,i)+vec_scr(3,3,i)/12 <= 0.5)
        vec_scr(:,:,i) = [];
    end
end


l1 = 0;
for i = 1: length(disease_factors) - 1
    l1 = l1 + i;
end

final_change = zeros(l1,4);

base = 2;
j = 1;
    for k = 1: length(disease_factors) - 1
        for l = base : length(disease_factors)
            %% section disease factors patients
            dis_fact_1 = disease_factors(k)
            dis_fact_2 = disease_factors(l)
            % setting vector labels
             final_change(j,1) = dis_fact_1;
            final_change(j,2) = dis_fact_2;

            count_dis = sum((vec_scr(1,dis_fact_1,:) == 1 & (vec_scr(1,dis_fact_2,:) == 1 | vec_scr(1,dis_fact_2,:) == 2) | vec_scr(1,dis_fact_1,:) == 2 & (vec_scr(1,dis_fact_2,:) == 1 | vec_scr(1,dis_fact_2,:) == 2)));


            count_norm = sum(vec_scr(1,dis_fact_1,:) == 0  & vec_scr(1,dis_fact_2,:) == 0 );

            disease = zeros(3,56,count_dis);
            normal = zeros(3,56,count_norm);

            l1 = size(vec_scr,3);
            
            if count_dis <= 2
                j = j + 1;
                j
                continue;
            end

            count_dis = 1;
            count_norm = 1;
            %%
            for i = 1:l1
                if (vec_scr(1,dis_fact_1,i) == 1 & (vec_scr(1,dis_fact_2,i) == 1 | vec_scr(1,dis_fact_2,i) == 2) | vec_scr(1,dis_fact_1,i) == 2 & (vec_scr(1,dis_fact_2,i) == 1 | vec_scr(1,dis_fact_2,i) == 2))
                    disease(:,:,count_dis) = vec_scr(:,:,i);
                    count_dis = count_dis + 1;

                elseif (vec_scr(1,dis_fact_1,i) == 0  & vec_scr(1,dis_fact_2,i) == 0 )
                    normal(:,:,count_norm) = vec_scr(:,:,i);
                    count_norm = count_norm + 1;

                end
            end

            l1 = 100;
            av_chng_dis = zeros(l1,1);
            for i = 1:l1
                % calculating differnce in mean 
                lngth= 1000;

                dif_time_dis = mean(bootstrp(lngth,@mean,disease(3,4,:))) + mean(bootstrp(lngth,@mean,disease(3,3,:))/12);
                dif_scr_dis = mean(bootstrp(lngth,@mean,disease(3,56,:)));
                av_chng_dis(i) = dif_scr_dis / dif_time_dis;
            end

            %% fill final change
           
            final_change(j,3) = count_dis;
            final_change(j,4) = mean(av_chng_dis);
            j = j +1;
        end
        base = base + 1;
    end

