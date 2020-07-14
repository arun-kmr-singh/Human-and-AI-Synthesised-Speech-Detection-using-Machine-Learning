
clc;
clear all;
close all;

%% Part 1

%myRecording = getaudiodata(recObj); % myRecording is a Vector storing 16-bit precision samples.
Fs=44100;

[myRecording,Fs]=audioread('hu_rec1.wav');

%sound(myRecording,Fs);
info = audioinfo('hu_rec1.wav'); % info contains detail about audio file.

T = 1/Fs;             % Sampling period       
L = 8000;             % Length of signal i.e 8 second
t = (0:L-1)*T;        % Time Vector

t1= 0:seconds(T):seconds(info.Duration); % 0 to sampling time i.e time gap between two time sampls.%seconds refer values are in seconds.
t1 = t1(1:end-1);


figure('Name','Spectrograph');
subplot(3,1,1);
plot(t1,myRecording);
xlabel('Time(s)'); 
ylabel('Amplitude');
title('Time Domain');


x=fft(myRecording);


P2 = abs(x/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;   % Defined frequency domain


subplot(3,1,2);
plot(f,P1);
%plot(abs(x));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Frequency Domain');

phase = (angle(x));
Iv = 1:length(f);
subplot(3,1,3);
plot(f,phase(Iv)*(180/pi));
grid on;
xlabel('Frequency (Hz)');
ylabel('Phase');
title('Frequency Domain');

fprintf("Press Enter to Continue...");
%pause;
%% Continued

%figure('Name','Spectrogram');
%spectrogram(myRecording,'yaxis')
%colormap bone







