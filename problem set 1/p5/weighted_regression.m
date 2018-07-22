% Start from scratch, cause I'm a bit anal:
clear all
clc
load_quasar_data

% get data for the eqs
m = size(train_qso, 2);
y = train_qso(1, :)';
x = [ones(m, 1) lambdas];

% get the weights associated to a given query
% point x_q based on a parameter t:
function w = weights(x_q, x, t)
  w = exp(-((x_q - x) .^ 2) / (2 * (t ^ 2)));
end

% estimate y_q given the weights for x_q:
function y_q = estimate(x_q, x, y, t)
  w = diag(weights(x_q, x(:, 2), t));
  theta = inv(x' * w * x) * (x' * w * y);
  y_q = [1 x_q] * theta;
end

% weighted regression.
function y_r = w_r(x, y, t)
  y_r = [];
  for i = 1 : size(x, 1)
    y_r(end + 1) = estimate(x(i, 2), x, y, t);
  end
end

% plot everything!
% t_ = [1 5 10 100 1000];
% colors = ['k*', 'r*', 'b*', 'y*', 'g*'];
% for i = 1 : size(t_, 2)
%   y_ = w_r(x, y, t_(i));
%   plot(lambdas', y_, colors(i))
%   hold on
% end
% plot(lambdas', y, 'k*')

% t = 5.;
% m_train = [];
% for i = 1 : size(train_qso, 1)
%   m_train(end + 1, :) = w_r(x, train_qso(i, :)', t);
% end
% save('m_train.txt', 'm_train');

% m_test = [];
% for i = 1 : size(test_qso, 1)
%   m_test(end + 1, :) = w_r(x, test_qso(i, :)', t);
% end
% save('m_test.txt', 'm_test');

% load('m_test.txt')
% plot(lambdas, m_test(2, :))