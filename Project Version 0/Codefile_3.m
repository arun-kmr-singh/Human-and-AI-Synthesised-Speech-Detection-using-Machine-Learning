clc;
clear all;
close all;
%myRecording = getaudiodata(recObj); % myRecording is a Vector storing 16-bit precision samples.
Fs=44100;

[myRecording,Fs]=audioread('hu_rec1.wav');

%sound(myRecording,Fs);
info = audioinfo('hu_rec1.wav'); % info contains detail about audio file.

x=fft(myRecording);                      % Equation 1

l=length(myRecording);
N=l/2;                      % Required length of Signal
phase = (angle(x));

K=100;                      % K segments
M=N/K;                      % Length of Each Seqments.


p=x.*conj(x);                            % Equation 2
Y=x(1:N);
P=real(p(1:N));


for m = 1:1000
    
    for n = 1:1000
        
        pf = Y(m)*Y(n);
        sf = conj (Y(m)+Y(n));
        B(m,n) =(pf*sf);                 % Equation 3
        
        apf = abs(Y(m))*abs(Y(n));
        asf = abs(Y(m)+Y(n));
        BM(m,n) = abs(apf*asf);          % Equation 4
        
        af = angle(Y(m))+angle(Y(n));
        df = angle(Y(m)+Y(n));
        BA(m,n) = af-df;                 % Equation 5
        
    end
    
end

for m=1:1000
    
    for n = 1:1000
        
        pp = abs(Y(m)*Y(n));
        sp = abs(Y(m)+Y(n));
        
        RTP(m,n) = abs((pp^2)*(sp^2));
        

    end
    
end


BIC = real(B./(sqrt(RTP)));                    % Equation 6
magnitude_BIC = abs(BIC);


imshow(magnitude_BIC);




























