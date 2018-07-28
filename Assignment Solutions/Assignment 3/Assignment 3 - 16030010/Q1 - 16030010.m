data=importdata('Q1Data.mat');

prior = zeros(1,3);
for num_rows = 1:3
    delta1 = 0;
    delta2 = 0;
    delta3 = 0;
       if(num_rows-1 == 0)
           delta1 = 1;
       elseif(num_rows-2==0)
           delta2 = 1;
       elseif(num_rows-3==0)
           delta3=1;
       end
     prior(num_rows) = 3/10*delta3 + 1/10*delta2 + 6/10*delta1;
end
disp(prior);
count = 0;
count1 = 0;
count2 = 0;
count3 = 0;
num = 2;
for num_rows = 1:30
    if( data(num_rows,2)==num && data(num_rows,3)==num && data(num_rows,4)==num && data(num_rows,5)==num )
        count = count + 1;
        if(data(num_rows, 6) == 1)
            count1 = count1 + 1;
        elseif (data(num_rows, 6) == 2)
            count2 = count2 + 1;
        else 
            count3 = count3 + 1;   
        end
   end
end

likelihood = zeros(1,3);
likelihood(1,1) = count1/count;
likelihood(1,2) = count2/count;
likelihood(1,3) = count3/count;

disp(['ML: ' num2str(max(likelihood).') ]) ;


MAP = zeros(1,3);
MAP(1,1) = likelihood(1,1) * prior(1,1);
MAP(1,2) = likelihood(1,2) * prior(1,2);
MAP(1,3) = likelihood(1,3) * prior(1,3);
[m,i] = max(MAP);
disp(['MAP: ' num2str(+i)]);

