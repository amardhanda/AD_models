%mmse = load('/Users/amardhanda/Documents/MATLAB/AD/MoCA_mapped_MMSE/norma_mapped');
mmse = load('/Users/amardhanda/Documents/MATLAB/AD/MoCA_mapped_MMSE/disease_mapped');

test = 42; % 42 for MMSE /  56 for MoCA

%% filter out min 6 months since 
vec_scr = mmse.vector;

disease_factors  = [9,13,15,16,17,19,21,27,48];

%% filter out min 6 months since 
l1 = 0;


for i = 3:11
    for j = 2:i-1
        for k = 1 : j -1
        l1 = l1+1;
        end
    end
end

final_change = zeros(l1,5);

base = 2;
j = 1;

%% obesity smoking

for k = 1: length(disease_factors)
     %% section disease factors patients
     dis_fact_1 = 33;
     dis_fact_2 = 10;
     dis_fact_3 = disease_factors(k);
     % setting vector labels
     final_change(j,1) = dis_fact_1;
     final_change(j,2) = dis_fact_2;
     final_change(j,3) = dis_fact_3;

     
     count_dis = sum((vec_scr(1,34,:)./vec_scr(1,33,:).^2 >= 0.0427 & vec_scr(1,dis_fact_2,:) >= 6 & vec_scr(1,dis_fact_2,:) <= 80) & (vec_scr(1,dis_fact_3,:) == 1 | vec_scr(1,dis_fact_3,:) == 2));


     count_norm = sum(vec_scr(1,34,:)./vec_scr(1,33,:).^2 < 0.0427 & vec_scr(1,dis_fact_2,:) >= 0 & vec_scr(1,dis_fact_2,:) <= 5 & (vec_scr(1,dis_fact_3,:) == 0));

     disease = zeros(3,56,count_dis);
     normal = zeros(3,56,count_norm);

      l1 = size(vec_scr,3);
            
      if count_dis <= 1
            j = j + 1;
      continue;
      end
      
     count_dis = 1;
            count_norm = 1;
            %%
            for i = 1:l1
                if (vec_scr(1,34,i)./vec_scr(1,33,i).^2 >= 0.0427 & vec_scr(1,dis_fact_1,i) >= 6 & vec_scr(1,dis_fact_1,i) <= 80 & (vec_scr(1,dis_fact_3,i) == 1 | vec_scr(1,dis_fact_3,i) == 2))
                    disease(:,:,count_dis) = vec_scr(:,:,i); 
                    count_dis = count_dis + 1;

                elseif (vec_scr(1,34,i)./vec_scr(1,33,i).^2 < 0.0427 & vec_scr(1,dis_fact_1,i) >= 0  & vec_scr(1,dis_fact_1,i) <= 5 & (vec_scr(1,dis_fact_3,i) == 0))
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
                dif_scr_dis = mean(bootstrp(lngth,@mean,disease(3,test,:)));
                av_chng_dis(i) = dif_scr_dis / dif_time_dis;
            end

            %% fill final change
           
            final_change(j,4) = count_dis;
            final_change(j,5) = mean(av_chng_dis);
            j = j +1;
   
end

%% obesity and else
base = 2;

for k = 1: length(disease_factors) - 1
    for l = base: length(disease_factors)
            %% section disease factors patients
            dis_fact_1 = 33;
            dis_fact_2 = disease_factors(k);
            dis_fact_3 = disease_factors(l);
            % setting vector labels
             final_change(j,1) = dis_fact_1;
            final_change(j,2) = dis_fact_2;
            final_change(j,3) = dis_fact_3;

            count_dis = sum(vec_scr(1,34,:)./vec_scr(1,33,:).^2 >= 0.0427 & (vec_scr(1,dis_fact_2,:) == 1 | vec_scr(1,dis_fact_2,:) == 2) & (vec_scr(1,dis_fact_3,:) == 1 | vec_scr(1,dis_fact_3,:) == 2));


            count_norm = sum(vec_scr(1,34,:)./vec_scr(1,33,:).^2 < 0.0427 & vec_scr(1,dis_fact_2,:) == 0 & vec_scr(1,dis_fact_3,:) == 0);

            disease = zeros(3,56,count_dis);
            normal = zeros(3,56,count_norm);

            l1 = size(vec_scr,3);
            
            if count_dis <= 1
                j = j + 1;
                j
                continue;
            end

            count_dis = 1;
            count_norm = 1;
            %%
            for i = 1:l1
                if (vec_scr(1,34,i)./vec_scr(1,33,i).^2 >= 0.0427 & (vec_scr(1,dis_fact_2,i) == 1 | vec_scr(1,dis_fact_2,i) == 2)  & (vec_scr(1,dis_fact_3,i) == 1 | vec_scr(1,dis_fact_3,i) == 2))
                    disease(:,:,count_dis) = vec_scr(:,:,i);
                    count_dis = count_dis + 1;

                elseif (vec_scr(1,34,i)./vec_scr(1,33,i).^2 < 0.0427 & (vec_scr(1,dis_fact_2,i) == 0) & (vec_scr(1,dis_fact_3,i) == 0))
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
                dif_scr_dis = mean(bootstrp(lngth,@mean,disease(3,test,:)));
                av_chng_dis(i) = dif_scr_dis / dif_time_dis;
            end

            %% fill final change
           
            final_change(j,4) = count_dis;
            final_change(j,5) = mean(av_chng_dis);
            j = j +1;
   
    end
    base = base +1;
end


%% smoking 

base = 2;
    for k = 1: length(disease_factors) - 1
        for l = base: length(disease_factors)
            %% section disease factors patients
            dis_fact_1 = 10;
            dis_fact_2 = disease_factors(k);
            dis_fact_3 = disease_factors(l);
            % setting vector labels
             final_change(j,1) = dis_fact_1;
            final_change(j,2) = dis_fact_2;
            final_change(j,3) = dis_fact_3;

            count_dis = sum((vec_scr(1,dis_fact_1,:) >= 6 & vec_scr(1,dis_fact_1,:) <= 80) & (vec_scr(1,dis_fact_2,:) == 1 | vec_scr(1,dis_fact_2,:) == 2)& (vec_scr(1,dis_fact_3,:) == 1 | vec_scr(1,dis_fact_3,:) == 2));

            count_norm = sum(vec_scr(1,dis_fact_1,:) >= 0  & vec_scr(1,dis_fact_1,:) <= 5 & vec_scr(1,dis_fact_2,:) == 0 & vec_scr(1,dis_fact_3,:) == 0 );

            disease = zeros(3,56,count_dis);
            normal = zeros(3,56,count_norm);

            l1 = size(vec_scr,3);
            
            if count_dis <= 1
                j = j + 1;
                j
                continue;
            end

            count_dis = 1;
            count_norm = 1;
            
            for i = 1:l1
                if ((vec_scr(1,dis_fact_1,i) >= 6 & vec_scr(1,dis_fact_1,i) <= 80) & (vec_scr(1,dis_fact_2,i) == 1 | vec_scr(1,dis_fact_2,i) == 2) & (vec_scr(1,dis_fact_3,i) == 1 | vec_scr(1,dis_fact_3,i) == 2))
                    disease(:,:,count_dis) = vec_scr(:,:,i);
                    count_dis = count_dis + 1;

                elseif (vec_scr(1,dis_fact_1,i) >= 0  & vec_scr(1,dis_fact_1,i) <= 5 & vec_scr(1,dis_fact_2,i) == 0 & vec_scr(1,dis_fact_3,i) == 0 )
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
                dif_scr_dis = mean(bootstrp(lngth,@mean,disease(3,test,:)));
                av_chng_dis(i) = dif_scr_dis / dif_time_dis;
            end

            %% fill final change
           
            final_change(j,4) = count_dis;
            final_change(j,5) = mean(av_chng_dis);
            j = j +1;
   
        end
        base = base +1;
    end
    
    %% other values 
    
  
 for k = 1: length(disease_factors) - 2
        for l = k+1 : length(disease_factors) - 1
            for m = l+1 : length(disease_factors) 
            %% section disease factors patients
            dis_fact_1 = disease_factors(k)
            dis_fact_2 = disease_factors(l)
             dis_fact_3 = disease_factors(m)
            % setting vector labels
             final_change(j,1) = dis_fact_1;
            final_change(j,2) = dis_fact_2;
            final_change(j,3) = dis_fact_3;

            count_dis = sum((vec_scr(1,dis_fact_1,:) == 1 | vec_scr(1,dis_fact_1,:) == 2) &  (vec_scr(1,dis_fact_2,:) == 1 | vec_scr(1,dis_fact_2,:) == 2) & (vec_scr(1,dis_fact_3,:) == 1 | vec_scr(1,dis_fact_3,:) == 2));


            count_norm = sum(vec_scr(1,dis_fact_1,:) == 0  & vec_scr(1,dis_fact_2,:) == 0 & vec_scr(1,dis_fact_3,:) == 0);

            disease = zeros(3,56,count_dis);
            normal = zeros(3,56,count_norm);

            l1 = size(vec_scr,3);
            
            if count_dis <= 1
                j = j + 1;
                j
                continue;
            end

            count_dis = 1;
            count_norm = 1;
            %%
            for i = 1:l1
                if ((vec_scr(1,dis_fact_1,i) == 1 | vec_scr(1,dis_fact_1,i) == 2) &  (vec_scr(1,dis_fact_2,i) == 1 | vec_scr(1,dis_fact_2,i) == 2) & (vec_scr(1,dis_fact_3,i) == 1 | vec_scr(1,dis_fact_3,i) == 2))
                    disease(:,:,count_dis) = vec_scr(:,:,i);
                    count_dis = count_dis + 1;

                elseif (vec_scr(1,dis_fact_1,i) == 0  & vec_scr(1,dis_fact_2,i) == 0 & vec_scr(1,dis_fact_3,i) == 0)
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
                dif_scr_dis = mean(bootstrp(lngth,@mean,disease(3,test,:)));
                av_chng_dis(i) = dif_scr_dis / dif_time_dis;
            end

            %% fill final change
           
            final_change(j,4) = count_dis;
            final_change(j,5) = mean(av_chng_dis);
            j = j +1;
        end
        
        end
 end

