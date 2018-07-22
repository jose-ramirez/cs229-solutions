function [theta, x, y] = titanic_data()
  clear all
  x = load('data.txt');
  y = x(:, 7);
  x(:, 7) = [];
  [r, c] = size(x);
  theta = zeros(c + 1, 1);
  x = [ones(r, 1) x];
end