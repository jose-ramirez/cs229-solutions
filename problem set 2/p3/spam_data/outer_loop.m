% ----------------------------------------------------------------------- %
% ---------------                Outer loop                -------------- %
% ----------------------------------------------------------------------- %
training_set_size_list = [50, 100, 200, 400, 800, 1400];
%% SVM training %%
test_errors_svm = zeros(length(training_set_size_list), 1);
total_svms_to_avg = 10;
[M, tokenlist, category] = readMatrix('data/MATRIX.TEST');
Xtest = M;
ytest = (2 * category - 1)';
for train_ind = 1:length(training_set_size_list)
  for iter = 1:total_svms_to_avg
    num_train = training_set_size_list(train_ind);
    svm_train;
    svm_test;
    test_errors_svm(train_ind) = test_errors_svm(train_ind) + test_error;
  end
end
test_errors_svm = test_errors_svm / total_svms_to_avg;

%% Naive Bayes training %%
test_errors_nb = zeros(length(training_set_size_list), 1);
for train_ind = 1:length(training_set_size_list)
num_train = training_set_size_list(train_ind);
nb_train;
nb_test;
test_errors_nb(train_ind) = error;
end
figure;
semilogx(training_set_size_list, test_errors_svm, 'bs-', 'linewidth', 2);
hold on;
semilogx(training_set_size_list, test_errors_nb, 'ko-', 'linewidth', 2);
legend('SVM error', 'NB error');
%set(gca, 'fontsize', 18);
axis([min(training_set_size_list), max(training_set_size_list), 0, .04]);