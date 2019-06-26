tic
a = load('energy_datasheet.mat');
b = load('entropy_datasheet.mat');
c = load('kurtosis_datasheet.mat');
d = load('skewness_datasheet.mat');
a = a.energy_datasheet; b = b.entropy_datasheet; c = c.kurtosis_datasheet; d = d.skewness_datasheet;

datasheet = [a(:,1:5) b(:,1:5) c(:,1:5) d(:,1:5) a(:,7)];
norm_datasheet = normalize(datasheet(:,1:20));
norm_datasheet = [norm_datasheet datasheet(:,21)];
datasheet = norm_datasheet;

%Separating the data and the labels.
data = datasheet(:,1:20);
label = datasheet(:,21);

random = randperm(length(datasheet));

data_r = []; label_r = []; data_p = []; label_p = [];
breakp = floor(length(datasheet)*0.8);
for i = 1:breakp
data_r(i,1:21) = datasheet(random(i),1:21);
%label_r(i,:) = label(random(i),:);
end

for i = breakp+1:length(datasheet)
data_p(i-breakp,1:21) = datasheet(random(i),1:21);
%label_p(i-1000,:) = label(random(i),:);
end

logical1_r = data_r(:,21) == 1 ;
data_r(logical1_r,21) = 3 ;
logical2_r = data_r(:,21) == 2 ;
data_r(logical2_r,21) = 3 ;

label_r = data_r(:,21);
data_p_future = data_p;

logical1_p = data_p(:,21) == 1 ;
data_p(logical1_p,21) = 3 ;
logical2_p = data_p(:,21) == 2 ;
data_p(logical2_p,21) = 3 ;

label_p = data_p(:,21);

c1 = fitcsvm(data_r(:,1:20),data_r(:,21),'Standardize',true,'KernelFunction','rbf',...
    'KernelScale','auto');

CVSVMModel = crossval(c1,'kfold',10);
c1 = CVSVMModel.Trained{1};

pred = predict(c1,data_p(:,1:20));

[TP, FP, TN, FN] = stat_params(label_p, pred);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Level 1 Completed.


logical3 = label_p==pred;
logical4 = false(length(pred),1);

for i=1:size(pred)
if((logical1_p(i) ==1 ||logical2_p(i) ==1)&&logical3(i) ==1)
    logical4(i) = 1 ;
end
end
logical4 =logical4';
level2_datasheet = data_p_future(logical4,1:21) ;


data2 = level2_datasheet(:,1:21);
%label2 = level2_datasheet(:,21);

random2 = randperm(length(data2));

data_r2 = []; label_r2 = []; data_p2 = []; label_p2 = [];
breakp =  floor(length(data2)*0.8);
for i = 1:breakp
data_r2(i,1:21) = data2(random2(i),1:21);
%label_r(i,:) = label(random(i),:);
end

for i = breakp+1 :length(data2)
data_p2(i-breakp,1:21) = data2(random2(i),1:21);
%label_p(i-84,:) = label(random(i),:);
end


c2 = fitcsvm(data_r2(:,1:20),data_r2(:,21),'Standardize',true,'KernelFunction','rbf',...
    'KernelScale','auto');

CVSVMModel1 = crossval(c2,'kfold',10);
c2 = CVSVMModel1.Trained{1};

pred2 = predict(c2,data_p2(:,1:20));
[TP1, FP1, TN1, FN1] = stat_params_2(data_p2(:,21), pred2);

accuracy = (TP+TN)/(TP+TN+FN+FP);
accuracy2 = (TP1+TN1)/(TP1+TN1+FN1+FP1);

toc
t = toc;
%accuracy = 70.91%
%accuracy2 = 90.00%
