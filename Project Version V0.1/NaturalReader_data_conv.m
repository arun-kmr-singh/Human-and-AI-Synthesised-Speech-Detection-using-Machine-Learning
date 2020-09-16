clc;
clear all;
close all;

%%

Class = "NaturalReader";

M_mean = zeros(1,79);
M_variance = zeros(1,79);
M_skewness = zeros(1,79);
M_kurtosis = zeros(1,79);
P_mean = zeros(1,79);
P_variance = zeros(1,79);
P_skewness = zeros(1,79);
P_kurtosis = zeros(1,79);
cl = strings(1,79);

for j = 1 : 79
    a = 'Audio/Data/n';
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

N_T = table(M_mean',M_variance',M_skewness',M_kurtosis',P_mean',P_variance',P_skewness',P_kurtosis',categorical(cl'),'VariableNames',{'M_mean','M_variance','M_skewness','M_kurtosis','P_mean','P_variance','P_skewness','P_kurtosis','Class'});

%%

c_mean = zeros(1,79);
c_var = zeros(1,79);

d_mean = zeros(1,79);
d_var = zeros(1,79);

dd_mean = zeros(1,79);
dd_var = zeros(1,79);


for j = 1 : 79
    a = 'Audio/Data/n';
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

N_T.MFCC_Mean = c_mean';
N_T.MFCC_Variance = c_var';

N_T.Delta_Mean = d_mean';
N_T.Delta_Variance = d_var';

N_T.DoubleDelta_Mean = dd_mean';
N_T.DoubleDelta_Variance = dd_var';



%%
writetable(N_T,'NaturalReader_data.txt');
writetable(N_T,'NaturalReader_data.csv');
save('NaturalReader_data.mat','N_T');







