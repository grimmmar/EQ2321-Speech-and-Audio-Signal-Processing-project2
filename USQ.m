in=-6:0.01:6;
n_bits = 2;
xmax = 4;

m = 0;
idx1 = sq_enc(in,n_bits,xmax,m);
outq1 = sq_dec(idx1,n_bits,xmax,m);
figure(1);
plot(in,outq1);
hold on;
plot(in,in);
title('midrise uniform quantizater');

m = 1.5;
idx2 = sq_enc(in,n_bits,xmax,m);
outq2 = sq_dec(idx2,n_bits,xmax,m);
figure(2);
plot(in,outq2);
hold on;
plot(in,in);
title('uniform quantizater with m=1.5');