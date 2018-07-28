data = bezdekIris;

c1 = data(1:50,:);
datac1 = datasample(c1,15);

c2 = data(51:100,:);
datac2 = datasample(c2,15);

c3 = data(101:150,:);
datac3 = datasample(c3,15);

for i=1:150
    for j=1:50
        if data(i,:) == datac1(j,:)
            data(i,:) = [];
        end
    end
end
