clc;
clear;

load ('assignment2.mat');
x = speech8;
n_bits = 2;
alen = 256;
ulen = 128;
M = 10;
[E, V, A, P] = analysis(x, alen, ulen, M);

VQ=V;
figure(1);
P2 = log(P);
phist = histogram(P2);
pmean = mean(phist.BinEdges);
pxmax = max(phist.BinEdges) - pmean;
pn_bits = 6;
idx = sq_enc(P2,pn_bits,pxmax,pmean);
outq = sq_dec(idx,pn_bits,pxmax,pmean);
figure(2);
plot(P);
hold on;
plot(exp(outq));
legend('pitch','quantized pitch(log)');
px = synthesis(E,VQ,A,exp(outq),ulen);
soundsc(px);