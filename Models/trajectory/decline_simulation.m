function [average_path,change] = decline_simulation(data, sntd_dev,final_decline)
    data_lngth = length(data);

    change = zeros(2, data_lngth);
    change(1,:) = data;
    
    mean_decline = final_decline;

    %% Test scores going up fro
    for i = 1: data_lngth
        decline = sntd_dev*randn(1) - mean_decline;
        new_scr = change(1,i) + decline;
        %working with limits 
        if (new_scr >= 30)
            decline = 30 - change(1,i);
        elseif (new_scr <= 0)
            decline = - change(1,i);
        end
        change(2,i) = decline;
    end

    %% generate average path 
    average_path = zeros(3,31);

    average_path(1,:) = 0:30;

    for i = 1:data_lngth
        for j = 0:30
            if change(1,i) == j
                average_path(2,j+1) = average_path(2,j+1) + change(2,i);
                average_path(3,j+1) = average_path(3,j+1) +1;
            end
        end
    end

    average_path(2,:) = average_path(2,:)./average_path(3,:);

    for j = 0:30
        temp = sum(change(1,:) == j);
        temp = zeros(temp,1);
        count = 0;
        for i = 1:data_lngth
            if (change(1,i) ==j)
                count = count + 1;
                temp(count) = change(2,i);
            end
        end
        average_path(3,j+1) = std(temp);
    end
end
