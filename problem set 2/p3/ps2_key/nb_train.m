[spmatrix, tokenlist, trainCategory] = readMatrix(sprintf('MATRIX.TRAIN.%d', num_train));

trainMatrix = full(spmatrix);
numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);
% ...
% YOUR CODE HERE

V = size(trainMatrix, 2);
neg = trainMatrix(find(trainCategory == 0), :);
pos = trainMatrix(find(trainCategory == 1), :);
neg_words = sum(sum(neg));
pos_words = sum(sum(pos));
neg_log_prior = log(size(neg,1) / numTrainDocs);
pos_log_prior = log(size(pos,1) / numTrainDocs);

for k=1:V,
neg_log_phi(k) = log((sum(neg(:,k)) + 1) / (neg_words + V));
pos_log_phi(k) = log((sum(pos(:,k)) + 1) / (pos_words + V));
end