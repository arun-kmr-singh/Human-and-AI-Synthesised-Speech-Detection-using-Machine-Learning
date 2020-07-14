
loadfile1 = load('Human_data.mat');
loadfile2 = load('SpikAI_data.mat');
loadfile3 = load('NaturalReader_data.mat');
loadfile4 = load('Replica_data.mat');

TH = loadfile1.T;
TS = loadfile2.P_T;
TN = loadfile3.N_T;
TR = loadfile4.R_T;

%%
Tnew_train = [TH(11:116,:);TS(1:210,:);TN(1:71,:);TR(1:113,:)];

Tnew_test = [TH(1:10,:);TS(211:230,:);TN(72:79,:);TR(114:126,:)];

%%

writetable(Tnew_train,'Training_Data.txt');
writetable(Tnew_train,'Training_Data.csv');
save('Training_Data.mat','Tnew_train');

writetable(Tnew_test,'Testing_Data.txt');
writetable(Tnew_test,'Testing_Data.csv');
save('Testing_Data.mat','Tnew_test');

%%

save('Model.mat','SVM_Quadratic','BoostedTrees','Weighted_KNN');

