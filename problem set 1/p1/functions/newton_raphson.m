function [th, l] = newton_raphson(th0, x, y, num_iterations)
  [mm, n] = size(x);
  l = [];
  th = th0;
  for i = 1 : num_iterations
    margins = y .* (x * th);
    l(end + 1) = (1/mm) * sum(log(1 + exp(-margins)));
    th -= inv(hessian(th, x, y)) * logistic_gradient(th, x, y);
  end
end