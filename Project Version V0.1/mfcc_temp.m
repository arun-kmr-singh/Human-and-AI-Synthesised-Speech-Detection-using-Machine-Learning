clc;
clear all;
close all;
%%
[data,Fs]=audioread('Audio/Data/s114.wav');
[data1,Fs1]=audioread('Audio/Data/r24.wav');


windowLength = round(0.03*Fs);
overlapLength = round(0.025*Fs);

windowLength1 = round(0.03*Fs1);
overlapLength1 = round(0.025*Fs1);

info = audioinfo('Audio/Data/s114.wav');

[melC,a,b,c] = mfcc(data,Fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
melC1 = mfcc(data1,Fs1,'WindowLength',windowLength1,'OverlapLength',overlapLength1);


[coeffs,delta,deltaDelta,loc] = mfcc(data,Fs);

[coeffs1,delta1,deltaDelta1,loc1] = mfcc(data1,Fs1);



%%

coeffs1(isinf(coeffs1)|isnan(coeffs1)) = 0;
coeffs(isinf(coeffs)|isnan(coeffs)) = 0;


mean(mean(coeffs))

mean(mean(coeffs1))

%%
melC1(isinf(melC1)|isnan(melC1)) = 0;
melC(isinf(melC)|isnan(melC)) = 0;


mean(mean(melC))

mean(mean(melC1))

