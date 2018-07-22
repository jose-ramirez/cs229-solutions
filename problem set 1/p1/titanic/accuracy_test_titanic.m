warning ('off', 'Octave:data-file-in-path')

addpath("../functions")

tic

[theta, x, y] = titanic_data();

[th, ll] = newton_raphson(theta, x, y, 200);

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

rmpath("../functions")