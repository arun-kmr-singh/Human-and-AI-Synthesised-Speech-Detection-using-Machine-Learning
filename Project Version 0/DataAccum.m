clc;
clear all;
close all;

%% For Human Voice Accumulation.

for i = 1 : 116
    a = 'Audio/Samples/s';
    b = num2str(i);
    c = '.mp3';
    d = [a b c];
    e = 'Audio/Data/s';
    f = '.wav';
    d2 = [e b f];
    
    [data,Fs]=audioread(d);
    info1 = audioinfo(d);
    
    samples=[1,info1.SampleRate * 5];
    [y,Fs]=audioread(d,samples);
    y=y(:,1);
    Fs=info1.SampleRate;
    
    audiowrite(d2,y,Fs);
    info2 = audioinfo(d2);
    
end    

%% Natural Reader Audio 


for i = 1 : 79
    a = 'Audio/Samples/n';
    b = num2str(i);
    c = '.wav';
    d = [a b c];
    e = 'Audio/Data/n';
    f = '.wav';
    d2 = [e b f];
    
    [data,Fs]=audioread(d);
    info1 = audioinfo(d);
    
    samples=[1,info1.SampleRate * 5];
    [y,Fs]=audioread(d,samples);
    y=y(:,1);
    Fs=info1.SampleRate;
    
    audiowrite(d2,y,Fs);
    info2 = audioinfo(d2);
    
end    

%% Speak.Ai Audio

for i = 1 : 230
    a = 'Audio/Samples/p';
    b = num2str(i);
    c = '.mp3';
    d = [a b c];
    e = 'Audio/Data/p';
    f = '.wav';
    d2 = [e b f];
    
    [data,Fs]=audioread(d);
    info1 = audioinfo(d);
    
    samples=[1,info1.SampleRate * 5];
    [y,Fs]=audioread(d,samples);
    y=y(:,1);
    Fs=info1.SampleRate;
    
    audiowrite(d2,y,Fs);
    info2 = audioinfo(d2);
    
end    

%% Replica AI Audio.


for i = 1 : 126
    a = 'Audio/Samples/r';
    b = num2str(i);
    c = '.wav';
    d = [a b c];
    e = 'Audio/Data/r';
    f = '.wav';
    d2 = [e b f];
    
    [data,Fs]=audioread(d);
    info1 = audioinfo(d);
    
    samples=[1,info1.SampleRate * 5];
    [y,Fs]=audioread(d,samples);
    y=y(:,1);
    Fs=info1.SampleRate;
    
    audiowrite(d2,y,Fs);
    info2 = audioinfo(d2);
    
end    






