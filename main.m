clear
close all
clc

% Read audio signal for Sig.wav
[y1, Fs1] = audioread('Sig.wav');

% Read audio signal for SigNoise.WAV
[y2, Fs2] = audioread('SigNoise.WAV');

colorStr = '#FF4F58FF';
color = sscanf(colorStr(2 : end), '%2x%2x%2x', [1 3]) / 255;

% Frequency domain parameters
N1 = 2^nextpow2(Fs1);
N2 = 2^nextpow2(Fs2);
k1 = 0 : 1 : N1 - 1;
k2 = 0 : 1 : N2 - 1;
xlim1 = N1 / 2;
xlim2 = N2 / 2;

% FFT Parameters
Y1 = fft(y1, N1);
Y2 = fft(y2, N2);

Fc = 3500;
offset = 80;
Wn1 = (Fc - offset) / (Fs2 / 2);
Wn2 = (Fc + offset) / (Fs2 / 2);
Wn = [Wn1 Wn2];

for n = 1 : 500
    h = fir1(n, Wn, 'low');
    H = fft(h, N2);
    y = conv(y2, h);
    Y = fft(y, N2);
    
    totaldist = 0;
    for i = 1 : length(Y1)
        distance = abs(abs(Y1(i)) - abs(Y(i)));
        if distance >= 2
            totaldist = totaldist + distance;
        else
        end
    end
    dx(n) = totaldist;
end

figure(7)
plot(1 : length(dx), dx, 'Color', color)
xlabel('Filter Order')
ylabel('Similitude')
title('$$d_{x[k]} = 2,\ B = 160\ \textrm{Hz}$$', 'interpreter', 'latex')