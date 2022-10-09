clc;
clear;

load ('assignment2.mat');
x = speech8;
alen = 128;
ulen = 128;
Fs = 8000;
M = 10;
k = 3.46;
r = 3;

[A, E, d] = encoder(x, alen, ulen, M);

Elog = log(E);
figure(1);
Ehist = histogram(Elog);
Emean = mean(Ehist.BinEdges);
Exmax = max(Ehist.BinEdges)-Emean;
Enbits = 5;
idx1=sq_enc(Elog,Enbits,Exmax,Emean);
outq1=sq_dec(idx1,Enbits,Exmax,Emean);

xmax = k*sqrt(var(d));
m = xmax/2^r;
idx_d = sq_enc(d, r, xmax, m);
outq_d = sq_dec(idx_d, r, xmax, m);

cb1=lsfCB1;
cb2=lsfCB2;
codeA = encodefilter(A, cb1, cb2);
Aq = decodefilter(codeA, cb1, cb2);

xhat = decoder(Aq, exp(outq1), outq_d, ulen); % reconstructed signal
%soundsc(xhat);

Qe = d - outq_d; % quantization error
% soundsc(Qe);

figure(2);
[Py, F1] = pwelch(x(1:ulen), [],[],[],Fs,'onesided'); % DFT frame
[Pd, F2] = pwelch(Qe(1:ulen), [],[],[],Fs,'onesided'); % DFT error frame
plot(F1,10*log10(Py)); 
hold on;
plot(F2,10*log10(Pd));
xlabel('frequency/Hz');ylabel('power/dB');
legend('PSD one frame input', 'PSD same frame residual')
title('DFT based spectrum of error');

SNR_PCM = 10*log10(var(d)/var(Qe));
SNR_ADPCM = 10*log10(var(x(1:length(xhat)))/var(x(1:length(xhat))-xhat));

rate_sample = (Enbits + ulen*r + 20)/ulen;
rate_second = Fs*rate_sample;