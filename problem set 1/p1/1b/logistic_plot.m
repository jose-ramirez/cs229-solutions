x = load('-ascii', 'logistic_x.txt');
y = load('-ascii', 'logistic_y.txt');

data = [x y];

x_r = data(data(:, 3) == -1, :);
x_g = data(data(:, 3) == 1, :);

plot(x_g(:, 1), x_g(:, 2), 'g.')
hold on
plot(x_r(:, 1), x_r(:, 2), 'r.')
