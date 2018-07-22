function H = hessian(theta, x, y)
  [m, n] = size(x);
  h = sigmoid(x * theta);
  g = zeros(size(theta));
  consts = sigmoid(-y .* x * theta);
  H = (1 / m) * x' * diag(consts .* (1 - consts)) * x;
endfunction