warning ('off', 'Octave:data-file-in-path')

addpath("data")

% Before using this method, set num_train to be the number of training
% examples you wish to read.

[sparseTrainMatrix, tokenlist, trainCategory] = ...
    readMatrix(sprintf('MATRIX.TRAIN.%d', num_train));

% Make y be a vector of +/-1 labels and X be a {0, 1} matrix.
ytrain = (2 * trainCategory - 1)';
Xtrain = 1.0 * (sparseTrainMatrix > 0);

numTrainDocs = size(Xtrain, 1);
numTokens = size(Xtrain, 2);

% Xtrain is a (numTrainDocs x numTokens) sparse matrix.
% Each row represents a unique document (email).
% The j-th column of the row $i$ represents if the j-th token appears in
% email i.

% tokenlist is a long string containing the list of all tokens (words).
% These tokens are easily known by position in the file TOKENS_LIST

% trainCategory is a (1 x numTrainDocs) vector containing the true 
% classifications for the documents just read in. The i-th entry gives the 
% correct class for the i-th email (which corresponds to the i-th row in 
% the document word matrix).

% Spam documents are indicated as class 1, and non-spam as class 0.
% For the SVM, we convert these to +1 and -1 to form the numTrainDocs x 1
% vector ytrain.

% This vector should be output by this method
average_alpha = zeros(numTrainDocs, 1);

% our kernel matrix (m x m at that too).
% K(i, j) = k(X(i, :), X(j, :), tau).
function K_ = K(X, m, tau)
  K_ = zeros(m, m);
  M = X * X';
  norms = sum(abs(X).^2,2);
  K_ = norms + norms' - (2 * M);
  K_ = exp(-K_ / (2 * (tau ** 2)));
end

%---------------
% YOUR CODE HERE
m_train = numTrainDocs;
lambda = 1 / (64 * m_train);
alpha = zeros(m_train, 1);
tau = 8;
Xtrain = full(Xtrain);

K_train = K(Xtrain, m_train, tau);

% our update step size.
count = 0;
max_steps = 40 * m_train;
for i = 1 : max_steps
  count = count + 1;
  % a random index:
  rnd_index = ceil(rand * m_train);
  % the full gradient of the risk function:
  margin = ytrain(rnd_index) * K_train(rnd_index, :) * alpha;
  g = -(margin < 1) * ytrain(rnd_index) * K_train(:, rnd_index) + ...
      (lambda * m_train * (alpha(rnd_index) * K_train(:, rnd_index)));
  % the alpha update:
  alpha = alpha - (g / sqrt(count));
  average_alpha = average_alpha + alpha;
end
average_alpha /= max_steps;
%---------------

rmpath("data")