clc;
clear;

load ('assignment2.mat');
x = speech8;
r = 3;
m = 0;
sigmax = sqrt(var(x));
k = 0:0.01:11.5;

for i = 1:length(k)
    xmax = k(i)*sigmax;
    idx = sq_enc(x, r, xmax, m);
    outq = sq_dec(idx, r, xmax, m);
    SNR(i) = 10*log10(var(x)/cov(x-outq));
end
figure(1);
plot(k,SNR);
[~,idx_opt] = max(SNR);
k_opt = k(idx_opt);
xlabel('k');ylabel('SNR/dB');
title('Determination of k');

% Plotting the SNR-Rate curve
n_bits = 1:16;
k_opts = [0.48, 1.56, k_opt, 4.95, 6.3, 7.65, 8.85, ...
    9.95, 10.6, 11.0, 11.1, 11.2, 11.15, 11.2, 11.15, 11.15];

for i = 1:length(k_opts)
    xmax = k_opts(i)*sqrt(var(x));
    
    idx = sq_enc(x, n_bits(i), xmax, m);
    outq = sq_dec(idx, n_bits(i), xmax, m);
    if i == 3
        bonus1 = outq;
    end
    
    SNR_opts(i) = 10*log10(var(x)/cov(x - outq));
end

figure(2);
plot(n_bits, SNR_opts); hold on;
plot(n_bits, 10*log10(2.^(2.*n_bits)));
xlabel('Rate');
ylabel('SNR');
legend('experiment', 'theoretical');
title('SNR-Rate curve');

rate = 8;%find no difference between them
xmax = k_opts(rate)*sigmax;
idx = sq_enc(speech8,n_bits(rate),xmax,0);
outq = sq_dec(idx,n_bits(rate),xmax,0);
% soundsc(outq);

noise = speech8-outq;%get quantization error signal
soundsc(noise);

for j=1:16 % comparison at low rate
    xmax2 = k_opts(j)*sigmax;
    m = xmax/(2^n_bits(j));
    idx2 = sq_enc(x,n_bits(j),xmax2,m);
    outq2 = sq_dec(idx2,n_bits(j),xmax2,m);
    SNR_lowrate(j)=10*log10(var(x)/cov(x-outq2));
    if j==3
        bonus2=outq2;
    end
end

figure(3);
plot(1:16,SNR_opts,'-x');
hold on;
plot(1:16,SNR_lowrate,'-x');
xlabel('Rate');ylabel('SNR');
legend('midrise','midtread');
title('SNR-rate Curve of midrise and midtread');

