clc;
clear all;
close all;
%%
[data,Fs]=audioread('Audio/Data/r25.wav');
[data1,Fs1]=audioread('Audio/Data/p182.wav');

info = audioinfo('Audio/Data/s114.wav');

[coeffs,delta,deltaDelta,loc] = mfcc(data,Fs);

[coeffs1,delta1,deltaDelta1,loc1] = mfcc(data1,Fs1);

%%
figure
melSpectrogram(data,Fs);
figure
melSpectrogram(data1,Fs1);


%%
coeffs1(isinf(coeffs1)|isnan(coeffs1)) = 0;
coeffs(isinf(coeffs)|isnan(coeffs)) = 0;

delta1(isinf(delta1)|isnan(delta1)) = 0;
delta(isinf(delta)|isnan(delta)) = 0;

deltaDelta1(isinf(deltaDelta1)|isnan(deltaDelta1)) = 0;
deltaDelta(isinf(deltaDelta)|isnan(deltaDelta)) = 0;


colCo = coeffs1(:);


m1 = mean(mean(coeffs));
vr1 = var(var(coeffs));


m2 = mean(mean(coeffs1));
vr2 = var(var(coeffs1));

var(colCo)

