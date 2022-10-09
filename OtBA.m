clc;
clear;

load ('assignment2.mat');
x = speech8;
n_bits = 2;
alen = 256;
ulen = 128;
Fs = 8000;
M = 10;
[E, V, A, P] = analysis(x, alen, ulen, M);
cb1=lsfCB1;
cb2=lsfCB2;

% Gain
E2=log(E);
figure(1);
hist1 = histogram(E2);
mean1 = mean(hist1.BinEdges);
xmax1 = max(hist1.BinEdges) - mean1;
n_bits1 = 5;%cannot hear distortion
idx1 = sq_enc(E2,n_bits1,xmax1,mean1);
outq1 = sq_dec(idx1,n_bits1,xmax1,mean1);

% Voiced/Unvoiced
Vq=V;

% Pitch
P2 = log(P);
figure(2);
phist = histogram(P2);
pmean = mean(phist.BinEdges);
pxmax = max(phist.BinEdges) - pmean;
pn_bits = 6;
idx2 = sq_enc(P2,pn_bits,pxmax,pmean);
outq2 = sq_dec(idx2,pn_bits,pxmax,pmean);

codeA=encodefilter(A,cb1,cb2);
Aq=decodefilter(codeA,cb1,cb2);

% 5 bits for Gain
% 6 bits for Pitch
% 1 bit for voice/unvoice
% 20 bits for LP

xq = synthesis(exp(outq1), Vq, Aq, exp(outq2), ulen);
SNR = 10*log10(var(x(1:length(xq)))/cov(x(1:length(xq)) - xq));
bpsp = (n_bits1 + pn_bits + 1 + 20)/ulen; % bit per sample
bps = (n_bits1 + pn_bits + 1 + 20)*Fs/ulen; % bit per second

soundsc(xq);