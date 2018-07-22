% reset all:
clear all
clc
load_quasar_data

% get data for the eqs
m = size(train_qso, 2);
y = train_qso(1, :)';
x = [ones(m, 1) lambdas];

% get the thetas for the (unweighted) regression problem:
theta = inv(x' * x) * x' * y;

% plot the data and the (unweighted) regression line:
plot(lambdas', theta' * x', 'k-', 'linewidth', 1)
hold on
plot(lambdas', y', 'r-', 'linewidth', 2)
