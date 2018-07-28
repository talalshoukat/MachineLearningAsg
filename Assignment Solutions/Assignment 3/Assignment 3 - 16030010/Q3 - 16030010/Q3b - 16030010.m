dt=importdata('Q3Learn.mat');

sampleArr = [15000; 20000; 25000; 28000; 30000; 35000; 40000];
errorArr=zeros(1,7);
for i = 1:length(sampleArr)
 
Error = 0;
for j=1:500
    data=datasample(dt,sampleArr(i,1));
zeroz = data(data(:,end)==0,:);
%disp(zeros)

ones = data(data(:,end)==1,:);
%disp(ones)

prior1 = length(ones)/(length(zeroz)+length(ones));
prior0 = length(zeroz)/(length(zeroz)+length(ones));
%disp(['Prior Zero: ' num2str(prior0)]);
%disp(['Prior One: ' num2str(prior1)]);

mean0 = (sum(zeroz(:,1)))/length(zeroz);
mean1 = (sum(ones(:,1)))/length(ones);
%disp(['mean Zero: ' num2str(mean0)]);
%disp(['mean One: ' num2str(mean1)]);

var0 = 0;
for k = 1:length(zeroz)
    var0 = var0 + ((mean0 - zeroz(k,1))^2);
end
%disp(['Variance Zero: ' num2str(var0/length(zeroz))]);
var0 = var0/length(zeroz);

var1 = 0;
for k = 1:length(ones)
    var1 = var1 + ((mean1 - ones(k,1))^2);
end
%disp(['Variance One: ' num2str(var1/length(ones))]);
var1 = var1/length(ones);



dataTest=importdata('Q3Test.mat');

%%%%%%%%%%for zeros%%%%%%%%%%%%%%
zerozPosterior = zeros(length(dataTest),1) ;
sdZero = sqrt(var0);
for k = 1:length(dataTest)
zerozPosterior(k,1) = (exp(-0.5 * ((dataTest(k,1) - mean0)./sdZero).^2) ./ (sqrt(2*pi) .* sdZero)) * prior0;
end


%%%%%%%%%%for ones%%%%%%%%%%%%%
onesPosterior = zeros(length(dataTest),1) ;
sdOne = sqrt(var1);
for k = 1:length(dataTest)
onesPosterior(k,1) = (exp(-0.5 * ((dataTest(k,1) - mean1)./sdOne).^2) ./ (sqrt(2*pi) .* sdOne)) * prior1;
end

%predVals = sign(zerozPosterior - onesPosterior);
predVals=zeros(size(dataTest,1),1);
for k=1:size(dataTest,1)
    if onesPosterior(k,1)>zerozPosterior(k,1)
        predVals(k,1)=1;
    else
          predVals(k,1)=0;
    end
end
predVals(predVals<0)=0;

sumPred = sum(predVals);
sumAct = sum(dataTest);
Error=(sum( (predVals(:,1) - dataTest(:,2)).^2 ) ./ size(dataTest,1))+Error;
end

errorArr(1,i)=Error/500;
disp(i);
end
plot(transpose(sampleArr),errorArr);


