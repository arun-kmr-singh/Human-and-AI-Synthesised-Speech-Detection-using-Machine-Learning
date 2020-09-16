clc;
clear all;
close all;
%myRecording = getaudiodata(recObj); % myRecording is a Vector storing 16-bit precision samples.


%[myRecording,Fs]=audioread('cutversion.wav');
[myRecording,Fs]=audioread('Audio/Data/p26.wav');

%sound(myRecording,Fs);
%info = audioinfo('cutversion.wav'); % info contains detail about audio file.
info = audioinfo('Audio/Data/p26.wav');  % info contains detail about audio file.

x=fft(myRecording);                      % Equation 1

l=length(myRecording);
N=l/2;                      % Required length of Signal
phase = (angle(x));

K=100;                      % K segments
M=l/K;                      % Length of Each Seqments.

p=x.*conj(x);                            % Equation 2
Y=x(1:N);
P=real(p(1:N));

B=zeros(M);BM=zeros(M);BA=zeros(M);RTP=zeros(M);

S=1;
T=M;

for i = 1 : K

    Y_temp=x(S:T);

    ld=Y_temp + Y_temp';

    %pf=Y_temp*(Y_temp');
    %sf=conj(ld);
    %B = B + (pf.*sf);                           % Equation 3

    apf=abs(Y_temp)*abs(Y_temp');
    asf=abs(ld);
    BM = BM + (abs(apf.*asf));                  % Equation 4

    af=unwrap(angle(Y_temp))+unwrap(angle(Y_temp'));
    df=unwrap(angle(ld));
    BA = BA + (af-df);                          % Equation 5

    %pp = abs(Y_temp*Y_temp');
    %sp = abs(ld);
    %RTP = RTP + (abs((pp.^2).*(sp.^2)));        
    
    S=T+1;
    T=T+M;
end        

%%

%B = B./K;
%RTP = RTP./K;

%P = sqrtm(RTP);
%P2 = sqrt(RTP);

%BIC = (B./(sqrt(RTP)));                    % Equation 7 (or Paritally it's Equation 6)
%magnitude_BIC = abs(BIC);
%angle_BIC = angle(BIC);

%mnmBIC = min(min(magnitude_BIC));
%magnitude_BIC = magnitude_BIC - mnmBIC;
%mxmBIC = max(max(magnitude_BIC));
%magnitude_BIC = magnitude_BIC/mxmBIC;

%mnaBIC = min(min(angle_BIC));
%angle_BIC = angle_BIC - mnaBIC;
%mxaBIC = max(max(angle_BIC));
%angle_BIC = angle_BIC/mxaBIC;


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


%%

figure
imshow(BM);
figure
imshow(BA);



































