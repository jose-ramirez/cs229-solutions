warning ('off', 'Octave:data-file-in-path')

addpath("data")

[spmatrix, tokenlist, category] = readMatrix('MATRIX.TEST');
testMatrix = full(spmatrix);
numTestDocs = size(testMatrix, 1);
numTokens = size(testMatrix, 2);
% ...
output = zeros(numTestDocs, 1);
%---------------
% YOUR CODE HERE
for k=1:numTestDocs,
  [i,j,v] = find(testMatrix(k,:));
  neg_posterior = sum(v .* neg_log_phi(j)) + neg_log_prior;
  pos_posterior = sum(v .* pos_log_phi(j)) + pos_log_prior;
  if (neg_posterior > pos_posterior)
    output(k) = 0;
  else
    output(k) = 1;
  end
end
%---------------
y = full(category);
y = y(:);
% Compute the error on the test set
error = sum(y ~= output) / numTestDocs;
%Print out the classification error on the test set
fprintf(1, 'Test error: %1.4f\n', error);

rmpath("data")