load ratingData.mat
load latentData.mat

u = size(R, 1);
v = size(R, 2);

pred = round(U'*V);

for n = 1:1000
    i = unidrnd(u);
    j = unidrnd(v);
    if I(i, j) == 1
        fprintf('rating = %f, pred = %f\n', R(i, j), pred(i, j));
    end
end