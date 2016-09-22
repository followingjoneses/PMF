load moviedata.mat

num_feature = 10;
num_movie = 3952;
num_user = 6040;
num_rating = length(train_vec);

sigma_U = 0.1;
sigma_V = 0.1;
lambda = 0.01;
learning_rate = 0.001;

U = sigma_U * randn(num_feature, num_user);
V = sigma_V * randn(num_feature, num_movie);
U_grad = zeros(num_feature, num_user);
V_grad = zeros(num_feature, num_movie);
R = zeros(num_user, num_movie);

for i = 1:length(train_vec)
    R(train_vec(i, 1), train_vec(i, 2)) = train_vec(i, 3);
end

I = R~=0;

iterations = 5000;

mean_rating = mean(train_vec(:, 3));

for i =1:iterations
    if mod(i, 8) == 0 && i < 32
        learning_rate = learning_rate/2;
    end
    
    pred = U'*V;
    E = 1/num_rating*(sum(sum(I.*(R-pred).^2)) + lambda/2 * (sum(sum(U.^2))+sum(sum(V.^2))));
    fprintf('iteration = %d, cost = %f\n', i, E);
    
    temp_U = U;
    temp_V = V;
    
    for u = 1:num_user
        cur_U = U(:, u);
        d_u = temp_V*(I(u, :).*(cur_U'*temp_V-R(u, :)))'+lambda*cur_U;
        U(:, u) = U(:, u) - learning_rate*d_u;
    end
    
    for v = 1:num_movie
        cur_V = V(:, v);
        d_v = temp_U*(I(:, v).*(temp_U'*cur_V-R(:, v)))+lambda*cur_V;
        V(:, v) = V(:, v) - learning_rate*d_v;
    end
end