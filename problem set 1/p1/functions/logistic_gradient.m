function g = logistic_gradient(theta, x, y)
  [m, n] = size(x);
  h = sigmoid(x * theta);
  g = zeros(size(theta));
  probs = sigmoid(-y .* x * theta);
  g = (-1 / m) * (x' * (probs .* y));
end
