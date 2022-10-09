function outq = sq_dec(idx,n_bits,xmax,m)
L = 2^n_bits;
delta = 2*xmax/L;
offset = m-xmax;
outq = offset+(2*idx+1)*delta/2;
end

