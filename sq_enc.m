function idx = sq_enc(in,n_bits,xmax,m)
L = 2^n_bits;
offset = m-xmax;
delta = 2*xmax/L;
n = length(in);
idx = zeros(n,1);
for i = 1:n
    d = in(i) - offset;
    if d < delta
        idx(i) = 0;
    elseif d >=(L-1)*delta
        idx(i) = L-1;
    else
        idx(i) = floor(d/delta);
    end
end

