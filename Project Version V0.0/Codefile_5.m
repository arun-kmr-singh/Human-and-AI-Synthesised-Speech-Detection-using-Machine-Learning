clc;
clear all;
close all;

%%

for j = 1 : 1
    a = 'Audio/Data/s';
    b = num2str(j);
    c = '.wav';
    d = [a b c];

    [y,Fs]=audioread(d);
    info = audioinfo(d);  
    x=fft(y);                      
        
    l=length(y);
    K=100;                      
    M=l/K;
    
    B=zeros(M);BM=zeros(M);BA=zeros(M);RTP=zeros(M);RTPF=zeros(M);RTPS=zeros(M);
    
    S=1;
    T=M;

    for i = 1 : K

        Y_temp=x(S:T);

        ld=Y_temp + Y_temp';

        pf=Y_temp*(Y_temp');
        sf=conj(ld);
        B = B + (pf.*sf);
        
        apf=abs(Y_temp)*abs(Y_temp)';
        asf=abs(ld);
        BM = BM + (abs(apf.*asf));                  

        af=angle(Y_temp)+angle(Y_temp)';
        df=angle(ld);
        BA = BA + (af-df);
        
        pp = abs(Y_temp*Y_temp');
        sp = abs(ld);
        RTPF = RTPF + (pp.^2);
        RTPS = RTPS + (sp.^2);
    
        S=T+1;
        T=T+M;
    end        

    B = B./K;
    RTPF = RTPF./K;
    RTPS = RTPS./K;
    RTP = RTPF.*RTPS;

    BIC = (B./(sqrt(RTP)));                    
    magnitude_BIC = abs(BIC);
    angle_BIC = angle(BIC);

    mnmBIC = min(min(magnitude_BIC));
    magnitude_BIC = magnitude_BIC - mnmBIC;
    mxmBIC = max(max(magnitude_BIC));
    magnitude_BIC = magnitude_BIC/mxmBIC;

    mnaBIC = min(min(angle_BIC));
    angle_BIC = angle_BIC - mnaBIC;
    mxaBIC = max(max(angle_BIC));
    angle_BIC = angle_BIC/mxaBIC;
    
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
    
    M_mean = mean(BM,'all');
    P_mean = mean(BA,'all');

end



%%






























