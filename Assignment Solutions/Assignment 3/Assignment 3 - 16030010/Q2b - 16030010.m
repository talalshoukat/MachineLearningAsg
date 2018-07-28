data=importdata('Q2Even.mat');
add = sum(data);
mean = add/length(data);
disp(['Mean: ' num2str(mean)]);
var = 0;

for i = 1:length(data)
    var = var + (mean - data(i, 1))^2;   
end

variance = var/length(data);
disp(['Variance: ' num2str(variance)]);
