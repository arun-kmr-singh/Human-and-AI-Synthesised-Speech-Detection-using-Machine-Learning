clc;
clear all;
close all;

%%

Class = "SpikAI";

M_mean = zeros(1,230);
M_variance = zeros(1,230);
M_skewness = zeros(1,230);
M_kurtosis = zeros(1,230);
P_mean = zeros(1,230);
P_variance = zeros(1,230);
P_skewness = zeros(1,230);
P_kurtosis = zeros(1,230);
cl = strings(1,230);

for j = 1 : 230
    a = 'Audio/Data/p';
    b = num2str(j);
    c = '.wav';
    d = [a b c];

    [y,Fs]=audioread(d);
    info = audioinfo(d);  
    x=fft(y);                      
        
    l=length(y);
    K=100;                      
    M=l/K;
    
    B=zeros(M);BM=zeros(M);BA=zeros(M);
    
    S=1;
    T=M;

    for i = 1 : K

        Y_temp=x(S:T);

        ld=Y_temp + Y_temp';
               
        apf=abs(Y_temp)*abs(Y_temp)';
        asf=abs(ld);
        BM = BM + (abs(apf.*asf));                  

        af=angle(Y_temp)+angle(Y_temp)';
        df=angle(ld);
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

P_T = table(M_mean',M_variance',M_skewness',M_kurtosis',P_mean',P_variance',P_skewness',P_kurtosis',categorical(cl'),'VariableNames',{'M_mean','M_variance','M_skewness','M_kurtosis','P_mean','P_variance','P_skewness','P_kurtosis','Class'});

%%

writetable(P_T,'SpikAI_data.txt');
writetable(P_T,'SpikAI_data.csv');
save('SpikAI_data.mat','P_T');







