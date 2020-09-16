clc;
clear all;
close all;
%%
[data,Fs]=audioread('Audio/Samples/s2.mp3');

info = audioinfo('Audio/Samples/s2.mp3')


%%
%samples=[1,length(data)-(13.42*Fs)];

samples=[1,220500]

[y,Fs]=audioread('Audio/Samples/s2.mp3',samples);
y=y(:,1);
Fs=44100;
audiowrite('Audio/Data/s2.wav',y,Fs);

info2 = audioinfo('Audio/Data/s2.wav')

%%

%samples=[1,220500];

info1 = audioinfo('Audio/nl5.mp3')
%y=y(:,1);
%Fs=44100;
st=1;
ed=240000;
%%
for i = 1 : 14
    samples=[st,ed];
    [y,Fs]=audioread('Audio/nl5.mp3',samples);
    e = 'Audio/Samples/n';
    f = '.wav';
    b = num2str(i+65);
    d2 = [e b f];
    
    audiowrite(d2,y,Fs);
    
    st=ed+1;
    ed=ed+240000;

end


%%

info1 = audioinfo('Audio/Samples/r19.wav');

info1 = audioinfo('Audio/Data/r20.wav')






