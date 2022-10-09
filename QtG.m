clc;
clear;

load ('assignment2.mat');
x = speech8;
n_bits = 2;
alen = 256;
ulen = 128;
M = 10;
[E, V, A, P] = analysis(x, alen, ulen, M);

figure(1);
hist1 = histogram(E);xlabel('E');ylabel('number');
mean1 = mean(hist1.BinEdges);
xmax1 = max(hist1.BinEdges) - mean1;
nbits1 = 6;%cannot hear distortion
idx1 = sq_enc(E,nbits1,xmax1,mean1);
outq1 = sq_dec(idx1,nbits1,xmax1,mean1); 
figure(2);
plot(E);
hold on;
plot(outq1);
legend('gain','quantized gain');
x1 = synthesis(outq1,V,A,P,ulen);
% soundsc(x1);

E2=log(E);
figure(3);
hist2 = histogram(E2);xlabel('logE');ylabel('number');
mean2 = mean(hist2.BinEdges);
xmax2 = max(hist2.BinEdges) - mean2;
nbits2 = 5;%cannot hear distortion
idx2 = sq_enc(E2,nbits2,xmax2,mean2);
outq2 = sq_dec(idx2,nbits2,xmax2,mean2);
figure(4);
plot(E);
hold on;
plot(exp(outq2));
legend('gain','quantized gain log');
x2 = synthesis(exp(outq2),V,A,P,ulen);
 soundsc(x2);