% Start from scratch, cause I'm a bit anal:
clear all
clc
load_quasar_data

load('m_train.txt')
load('m_test.txt')

% Metric returning the "distance" between two
% functions, i.e., how close they are to one
% another.
%
% We'll assume that t1 and t2 are row vectors.
function z = d(t1, t2)
  t = t1 - t2;
  z = sum(t * t');
end

% A kernel function.
function z = ker(t)
  z = max(1 - t, 0);
end

% Average error between observed data and the estimated data.
function z = average_error(observed, estimated)
  m = size(observed, 1);
  t = observed - estimated;
  z = sum(diag(t' * t)) / m;
end

% Returns a matrix with the distances between each
% spectrum in the datasets given.
function d_ = distance_matrix_(dataset_1, dataset_2)
  tic
  [m1, n1] = size(dataset_1);
  [m2, n2] = size(dataset_2);
  if (n1 != n2)
    error('the column sizes dont match')
  end
  r = max(m1, m2);
  s = min(m1, m2);
  d_ = zeros(r, s);
  for i = 1 : r
    for j = 1 : s
      d_(i, j) = d(dataset_1(i, :), dataset_2(j, :));
    end
  end
  d_ = d_ / max(d_(:));
  toc
end

% Testing distance_matrix_():
% t2 = distance_matrix_(m_train(:, 151:end), m_test(:, 151:end));

function [es, d_] = estimate_spectra_2(train_data, test_data)
  tic
  k = 3;
  m = size(test_data, 1);
  mm = size(train_data, 1);
  left_spectra = train_data(:, 1:50);
  right_spectra = train_data(:, 151:end);
  right_test_data = test_data(:, 151:end);
  es = zeros(m, 50);
  d_ = distance_matrix_(right_spectra, right_test_data);
  for i = 1 : m
    mask = ones(mm, 1);
    [sorted_distances i_] = sort(d_(:, i), 'ascend');
    h = max(d_(:, i));
    mask(i_((k + 1) : end)) = 0;
    kerns = ker(d_(:, i) / h);
    kerns = kerns .* mask;
    es(i, :) = (left_spectra' * kerns) / sum(kerns);
  end
  toc
end

% Training spectra distance matrix.
function d_ = distance_matrix(dataset_right)
  d_ = distance_matrix_(dataset_right, dataset_right);
end
% Testing disrance_matrix():
% t1 = distance_matrix(m_train(:, 151:end));

% Training spectra's left side reconstruction.
function [es d_] = estimate_spectra(data)
  [es d_] = estimate_spectra_2(data, data);
end

% Average training error.
[left_estimate, dists] = estimate_spectra(m_train);
s = average_error(m_train(:, 1:50), left_estimate)

% Average test error.
[left_estimate, dists] = estimate_spectra_2(m_train, m_test);
s = average_error(m_test(:, 1:50), left_estimate)

% Plotting examples 1 and 6.
figure;
plot(lambdas, m_test(1, :), 'k-', 'linewidth', 1)
hold on
plot(lambdas(1:50), left_estimate(1, :), 'r-', 'linewidth', 2)

figure;
plot(lambdas, m_test(6, :), 'k-', 'linewidth', 1)
hold on
plot(lambdas(1:50), left_estimate(6, :), 'r-', 'linewidth', 2)
