function [theta, x, y] = init_values()
  clear all
  x = load('-ascii', 'logistic_x.txt');
  y = load('-ascii', 'logistic_y.txt');
  [r, c] = size(x);
  theta = zeros(c + 1, 1);
  x = [ones(r, 1) x];
end