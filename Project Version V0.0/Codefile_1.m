clc;
clear all;
close all;

%{
    recObj is an audiorecorder object that defines 
    the sample rate,bit depth, and other properties of the recording.
%}
recObj = audiorecorder; 


Fs = 44100 ; % Fs contains sample rate of 44100 Hz i.e Fs represent sampling frequency in hertz.

nBits = 16 ; % 16-bit fixed point resolution will be used for audio recoding.

nChannels = 1 ; % channel will represent type of audio i.e 1 specifies mono and 2 specifies stereo.

ID = -1; % default audio input device i.e -1 represent default audio device of your PC. 


%{
    audiorecorder(Fs,nBits,nChannels,ID) will:
    sets the sample rate Fs (in hertz), 
    the bits per sample nBits, 
    and the number of channels nChannels
    and sets the audio input device to the device specified by ID.
%}
recObj = audiorecorder(Fs,nBits,nChannels,ID); 

%{
    % recObj is a audiorecorder object stores audio 
      sound for time interval 8 sec.
    % recordblocking records audio from an input device,
      for the number of seconds specified by length.
%}
disp('Start speaking.')
recordblocking(recObj,5); 
disp('End of Recording.');

play(recObj);

myRecording = getaudiodata(recObj); % myRecording is a Vector storing 16-bit precision samples.

audiowrite('hu_rec1.wav',myRecording,Fs);

figure('Name','Spectrograph');
subplot(2,1,1);
plot(myRecording);
xlabel('Time(s)'); 
ylabel('Amplitude');
title('Time Domain');


T = 1/Fs;             % Sampling period       
L = 8000;             % Length of signal i.e 8 second
t = (0:L-1)*T;        % Time Vector

x=fft(myRecording);

P2 = abs(x/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;   % Defined frequency domain

subplot(2,1,2);
plot(f,P1);
%plot(abs(x));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Frequency Domain');
