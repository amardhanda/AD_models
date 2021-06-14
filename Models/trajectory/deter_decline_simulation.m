function [average_path,change] = deter_decline_simulation(data,final_decline)
    data_lngth = length(data);

    change = zeros(2, data_lngth);
    change(1,:) = data;
    
 floor_effect = 3:-0.5:0.5;

    %% Test scores going up fro
    for i = 1: data_lngth

        %working with limits 
        if (data(i) >= 6)
            decline = -final_decline;
        elseif (data(i) <= 5)
            decline = -final_decline + floor_effect(data(i)+1);
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
