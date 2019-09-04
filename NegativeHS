%% training
clear;clc;
load traindata.mat

X = [traindata(81:240,:);traindata(1:80,:)]; Y = [zeros(160,1);ones(80,1)];

trainnum = 1:160; testnum = 161:240;
rand1 = randperm (160); rand1 = rand1(1:100);
rand2 = randperm(80)+160; rand2 = rand2(1:50);
rand3 = setdiff(trainnum,rand1); rand4 = setdiff(testnum,rand2);
rowtrain = [rand1,rand2];
rowtest = [rand3,rand4];
Xtrain = X(rowtrain,:); Ytrain = Y(rowtrain,:);
Xtest = X(rowtest,:); Ytest = Y(rowtest,:);
l = length(Ytrain);
c = cvpartition(l,'leaveout');
opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
    'OptimizeHyperparameters','auto','AcquisitionFunctionName','expected-improvement-plus');
svmmod = fitcsvm(Xtrain,Ytrain,'KernelFunction','rbf','HyperparameterOptimizationOptions',opts);

%% accuracy 
[label,dec_values] = predict(svmmod,Xtest);
accuracy = length(find(label==Ytest))./(240-l);
figure
plot(1:(240-l),Ytest,'b*',1:(240-l),label,'ro');

%% features performance
lossnew = kfoldLoss(fitcsvm(rocx,rocy,'CVPartition',c,'KernelFunction','rbf',...
    'BoxConstraint',svmmod.HyperparameterOptimizationResults.XAtMinObjective.BoxConstraint,...
    'KernelScale',svmmod.HyperparameterOptimizationResults.XAtMinObjective.KernelScale));
[ranking,weights] = ILFS(Xtest,Ytest,6,0);
ranking;
fprintf('Accuracy: %.2f%%, Error-Rate: %.2f \n',accuracy*100,lossnew);

%% ROC curve
long_dec_values = dec_values(:,2);
[rocx,rocy,~,~] = perfcurve(Ytest,long_dec_values,1);
plot(rocx,rocy);hold on;
for i = 4
    [rocx,rocy,~,~] = perfcurve(Ytest,Xtest(:,i),1);
    plot(rocx,rocy);hold on;
end
plot(rocx,rocx,'-');
xlabel('False positive rate'); ylabel('True positive rate');
legend('all','hippo','ILV','com','blur')
set(legend,'position',[0.45,0.15,0.4,0.18])

%% permutation test
fprintf('Permutation test ......\n');
Nsloop = 1000;
auc_rand = zeros(Nsloop,1);
for i=1:Nsloop
    label_rand = randperm(length(Ytest));
    deci_value_rand = long_dec_values(label_rand);
    [~,~,~,auc_rand(i)] = perfcurve(Ytest,deci_value_rand,1);
    clear label_rand
end
p_auc = mean(auc_rand > AUC);
disp(['Pvalue= ', num2str(p_auc)]);

%% histogram
figure;
histfit(auc_rand,30);hold on;
plot(AUC*ones(100,1),1:100);
title('Permutation distribution');

%% weight plot
figure
subplot(2,2,1)
gretna_plot_hub(unnamed,{'HippoVol','HippoFLAIR','TempoHornVol','TempoPoleContrast','.'});
set(gcf,'Position',[200   200   100   350])
subplot(2,2,2)
gretna_plot_hub(unnamed,{'HippoVol','HippoFLAIR','TempoHornVol','TempoPoleContrast','.'});
set(gcf,'Position',[200   178   620   350])
