data=importdata('Q3Learn.mat');

meanOrig = sum(data(:,1))/length(data);

varnc=0;
for i = 1:length(data)
    varnc = varnc + ((meanOrig - data(i,1)).^2);
end
%disp(var(data));

zeroz = data(data(:,end)==0,:);
%disp(zeros)

ones = data(data(:,end)==1,:);
%disp(ones)

prior1 = length(ones)/(length(zeroz)+length(ones));
prior0 = length(zeroz)/(length(zeroz)+length(ones));
disp(['Prior Zero: ' num2str(prior0)]);
disp(['Prior One: ' num2str(prior1)]);

mean0 = (sum(zeroz(:,1)))/length(zeroz);
mean1 = (sum(ones(:,1)))/length(ones);
disp(['mean Zero: ' num2str(mean0)]);
disp(['mean One: ' num2str(mean1)]);

var0 = 0;
for i = 1:length(zeroz)
    var0 = var0 + ((mean0 - zeroz(i,1))^2);
end
disp(['Variance Zero: ' num2str(var0/length(zeroz))]);
var0 = var0/length(zeroz);

var1 = 0;
for i = 1:length(ones)
    var1 = var1 + ((mean1 - ones(i,1))^2);
end
disp(['Variance One: ' num2str(var1/length(ones))]);
var1 = var1/length(ones);



dataTest=importdata('Q3Test.mat');

%%%%%%%%%%for zeros%%%%%%%%%%%%%%
zerozPosterior = zeros(length(dataTest),1) ;
sdZero = sqrt(var0);
for i = 1:length(dataTest)
zerozPosterior(i,1) = (exp(-0.5 * ((dataTest(i,1) - mean0)./sdZero).^2) ./ (sqrt(2*pi) .* sdZero)) * prior0;
end


%%%%%%%%%%for ones%%%%%%%%%%%%%
onesPosterior = zeros(length(dataTest),1) ;
sdOne = sqrt(var1);
for i = 1:length(dataTest)
onesPosterior(i,1) = (exp(-0.5 * ((dataTest(i,1) - mean1)./sdOne).^2) ./ (sqrt(2*pi) .* sdOne)) * prior1;
end

%predVals = sign(zerozPosterior - onesPosterior);
predVals=zeros(size(dataTest,1),1);
for i=1:size(dataTest,1)
    if onesPosterior(i,1)>zerozPosterior(i,1)
        predVals(i,1)=1;
    else
          predVals(i,1)=0;
    end
end
predVals(predVals<0)=0;

sumPred = sum(predVals);
sumAct = sum(dataTest);

SSE = sum( (predVals(:,1) - dataTest(:,2)).^2 );

disp(['SSE: ' num2str(SSE/2)]);
disp(['Max Likelihood: ' num2str(varnc/length(data))]);
