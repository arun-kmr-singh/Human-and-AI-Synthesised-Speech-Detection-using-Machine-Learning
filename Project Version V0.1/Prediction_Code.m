close all
clear all
clc

%%

mdls = load('Model.mat');
mdlsb = load('Model_Bclass.mat');
testdt = load('Testing_Data.mat');

mdl1 = mdls.Quadratic_SVM;
mdl2 = mdls.Boosted_Trees;
mdl3 = mdls.Weighted_KNN;

mdlb1 = mdlsb.Quad_SVM_Binary; 
mdlb2 = mdlsb.Logistic_Regression;
mdlb3 = mdlsb.Linear_SVM;


Torg = testdt.Tnew_test;
Torg_Binary = testdt.Tnew_test_onlybinary;

%% Predictions on Binary as well as All.

pred = mdl1.predictFcn(Torg);

pred_Binary = mdlb1.predictFcn(Torg_Binary);


%% For all Classification 4 vs 4.


iscorrect = pred == Torg.Class;
accuracy = (sum(iscorrect)/numel(pred))*100;

iswrong = pred ~= Torg.Class;
misclassRate = (sum(iswrong)/numel(pred))*100;

confusionchart(Torg.Class,pred);



%% For binary Classification Human vs AI.

Torg_Binary1.Bclass1 = pred_Binary;
%%
iscorrect_B = pred_Binary == Torg_Binary.Bclass;
accuracy_B = (sum(iscorrect_B)/numel(pred_Binary))*100;

iswrong_B = pred_Binary ~= Torg_Binary.Bclass;
misclassRate_B = (sum(iswrong_B)/numel(pred_Binary))*100;

confusionchart(Torg_Binary1.Bclass1,pred_Binary);





