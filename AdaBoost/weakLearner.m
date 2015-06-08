function y = weakLearner(h, x)

if(h.pos == 1)
    y =  double(x(:,h.dim) >= h.threshold);
else
    y =  double(x(:,h.dim) < h.threshold);
end

pos = find(y==0);
y(pos) = -1;