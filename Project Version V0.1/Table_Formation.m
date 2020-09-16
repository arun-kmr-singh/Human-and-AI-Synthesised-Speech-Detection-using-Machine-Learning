close all
clear all
clc

%%
loadfile1 = load('Human_data.mat');
loadfile2 = load('SpikAI_data.mat');
loadfile3 = load('NaturalReader_data.mat');
loadfile4 = load('Replica_data.mat');

TH = loadfile1.T;
TS = loadfile2.P_T;
TN = loadfile3.N_T;
TR = loadfile4.R_T;

%%
Tnew_train = [TH(23:250,:);TS(1:210,:);TN(1:71,:);TR(1:113,:)];

Tnew_test = [TH(1:30,:);TS(207:230,:);TN(68:79,:);TR(111:126,:)];


bcl = strings(622,1);
bclt = strings(82,1);
%%
for i = 1:228
    bcl(i) = "H";
end
%%
for i = 1:30
    bclt(i) = "H";
end

%%
Tnew_train_binary = Tnew_train;
Tnew_train_binary.Bclass = categorical(bcl);

Tnew_train_onlybinary = Tnew_train_binary;
Tnew_train_onlybinary.Bclass = categorical(bcl);
Tnew_train_onlybinary = removevars(Tnew_train_onlybinary, 'Class');

%%
Tnew_test_binary = Tnew_test;
Tnew_test_binary.Bclass = categorical(bclt);

Tnew_test_onlybinary = Tnew_test_binary;
Tnew_test_onlybinary.Bclass = categorical(bclt);
Tnew_test_onlybinary = removevars(Tnew_test_onlybinary, 'Class');

%%

writetable(Tnew_train,'Training_Data.txt');
writetable(Tnew_train,'Training_Data.csv');
save('Training_Data.mat','Tnew_train','Tnew_train_binary','Tnew_train_onlybinary');
%%
writetable(Tnew_test,'Testing_Data.txt');
writetable(Tnew_test,'Testing_Data.csv');
save('Testing_Data.mat','Tnew_test','Tnew_test_binary','Tnew_test_onlybinary');

%%

save('Model.mat','Quadratic_SVM','Boosted_Trees','Weighted_KNN');

%%


save('Model_Bclass.mat','Logistic_Regression','Linear_SVM','Quad_SVM_Binary');



