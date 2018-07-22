warning ('off', 'Octave:data-file-in-path')

addpath("data", "../functions")

tic

[theta, x, y] = init_values();

[th, ll] = newton_raphson(theta, x, y, 2);

predictions = sigmoid(x * th);

[r, c] = size(y);

total = 0;
for i = 1 : r
  if (y(i) == 1 && predictions(i) > 0.5) || (y(i) == -1 && predictions(i) < 0.5)
    total += 1;
  end
end

toc

accuracy = total / r * 100

rmpath("data", "../functions")