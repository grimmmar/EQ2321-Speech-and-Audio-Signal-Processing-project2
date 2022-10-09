clc;
clear;

load ('assignment2.mat');
x = speech8;
n_bits = 2;
alen = 256;
ulen = 128;
M = 10;
[E, V, A, P] = analysis(x, alen, ulen, M);

cb1=lsfCB1;
cb2=lsfCB2;

codeA=encodefilter(A,cb1,cb2);
Aq=decodefilter(codeA,cb1,cb2);