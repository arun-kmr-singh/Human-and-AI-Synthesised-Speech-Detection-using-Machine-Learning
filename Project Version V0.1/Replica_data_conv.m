clc;
clear all;
close all;

%%

Class = "Replica";

M_mean = zeros(1,126);
M_variance = zeros(1,126);
M_skewness = zeros(1,126);
M_kurtosis = zeros(1,126);
P_mean = zeros(1,126);
P_variance = zeros(1,126);
P_skewness = zeros(1,126);
P_kurtosis = zeros(1,126);
cl = strings(1,126);

for j = 1 : 126
    a = 'Audio/Data/r';
    b = num2str(j);
    c = '.wav';
    d = [a b c];

    [y,Fs]=audioread(d);
    info = audioinfo(d);  
    x=fft(y);                      
        
    l=length(y);
    K=98;                      
    M=l/K;
    
    B=zeros(M);BM=zeros(M);BA=zeros(M);
    
    S=1;
    T=M;

    for i = 1 : K

        Y_temp=x(S:T);

        ld=Y_temp + Y_temp';
               
        apf=abs(Y_temp)*abs(Y_temp');
        asf=abs(ld);
        BM = BM + (abs(apf.*asf));                  

        af=unwrap(angle(Y_temp))+unwrap(angle(Y_temp'));
        df=unwrap(angle(ld));
        BA = BA + (af-df);
        
            
        S=T+1;
        T=T+M;
    end        

        
    BA = BA./K;
    BM = BM./K;

    mn = min(min(BM));
    BM = (BM-mn);
    mx = max(max(BM));
    BM = BM/mx;

    mnb = min(min(BA));
    BA = (BA-mnb);
    mxb = max(max(BA));
    BA = BA/mxb;
    
    colBM = BM(:);
    colBA = BA(:);
    
    %pdM = fitdist(colBM,'Normal');
    %pdP = fitdist(colBA,'Normal');
    
    M_mean(j) = mean(colBM);
    M_variance(j) = var(colBM);
    M_skewness(j) = skewness(colBM);
    M_kurtosis(j) = kurtosis(colBM);
    P_mean(j) = mean(colBA);
    P_variance(j) = var(colBA);
    P_skewness(j) = skewness(colBA);
    P_kurtosis(j) = kurtosis(colBA);
    cl(j) = Class;
    

end

%%

R_T = table(M_mean',M_variance',M_skewness',M_kurtosis',P_mean',P_variance',P_skewness',P_kurtosis',categorical(cl'),'VariableNames',{'M_mean','M_variance','M_skewness','M_kurtosis','P_mean','P_variance','P_skewness','P_kurtosis','Class'});

%%

c_mean = zeros(1,126);
c_var = zeros(1,126);

d_mean = zeros(1,126);
d_var = zeros(1,126);

dd_mean = zeros(1,126);
dd_var = zeros(1,126);


for j = 1 : 126
    a = 'Audio/Data/r';
    b = num2str(j);
    c = '.wav';
    d = [a b c];

    [y,Fs]=audioread(d);
    
    [melCo,delta,deltaDelta,loc] = mfcc(y,Fs);

    melCo(isinf(melCo)|isnan(melCo)) = 0;
    delta(isinf(delta)|isnan(delta)) = 0;
    deltaDelta(isinf(deltaDelta)|isnan(deltaDelta)) = 0;
    
    melCo = melCo(:);
    delta = delta(:);
    deltaDelta = deltaDelta(:);
    
    c_mean(j) = mean(melCo);
    c_var(j) = var(melCo);

    d_mean(j) = mean(delta);
    d_var(j) = var(delta);

    dd_mean(j) = mean(deltaDelta);
    dd_var(j) = var(deltaDelta);


end


%%


R_T.MFCC_Mean = c_mean';
R_T.MFCC_Variance = c_var';

R_T.Delta_Mean = d_mean';
R_T.Delta_Variance = d_var';

R_T.DoubleDelta_Mean = dd_mean';
R_T.DoubleDelta_Variance = dd_var';





%%
writetable(R_T,'Replica_data.txt');
writetable(R_T,'Replica_data.csv');
save('Replica_data.mat','R_T');







