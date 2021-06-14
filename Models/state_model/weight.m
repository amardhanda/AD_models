clear all
close all 

load('states.mat');
%% filter 
min = 2;
max = 2.5;

temp = sum((demented(3,4,:)+demented(3,3,:)/12) > min & (demented(3,4,:)+demented(3,3,:)/12) < max)
vector = zeros(3,56,temp);

for i = 1 : length(demented)
    if (demented(3,4,i)+demented(3,3,i)/12) >= min & (demented(3,4,i)+demented(3,3,i)/12) < max
       vector(:,:,i) =  demented(:,:,i);
    end
end
%% Weight matrix
weights = cell(3,1);

t0 = 3;
t1 = 3;

lngth = 0;

for t0 = 1 : 3
    temp1 = 0;
    for t1 = 1 : 3
        temp = sum(vector(1,56,:) == t0 & vector(2,56,:) == t1);
        temp1 = temp1 + temp;
    end
        temp = zeros(3,temp1);
        temp(1,:) = 1: length(temp);  
        count = 1;
        
        for i = 1 :length(vector)   
            if(vector(1,56,i) == t0)
                temp(2,count) = vector(2,56,i);
                temp(3,count) = sum(temp(2,:) == temp(2,count))./count;
                count = count + 1;
            end  
        end 
        
        
        for i = 1 : length(temp) 
            for t1 = 1: 3
                if temp(2,i) == t1
                    temp(1,i) = sum(temp(2,1:i) == t1)/ sum(temp(2,:) == t1);
                end
            end   
        end
        
        weights{t0} = temp;
end

figure;
for t0 = 1 : 3
    subplot(3,1,t0);
    for t1 = 1  : 3
        temp = zeros(sum(weights{t0,1}(2,:) == t1),2);
        count = 1;
        for i  = 1: length(weights{t0,1})
            if weights{t0,1}(2,i) == t1
                temp(count,1) = weights{t0,1}(1,i);
                temp(count,2) = weights{t0,1}(3,i);
                count = count + 1;
            end
        end
        plot(temp(:,1),temp(:,2),'LineWidth',2);
        hold on
    end
    set(gca, 'FontSize', 16)
    lgd = legend([num2str(t0),' -> 1'], [num2str(t0),' -> 2'],[num2str(t0),' -> 3']);
    title(lgd,'Transition')
    title(['Transitions from State ' num2str(t0)], 'FontSize', 16);
    ylabel('Probability', 'FontSize', 16);
    

end

xlabel('Normalised Input', 'FontSize', 16);


