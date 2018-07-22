function z = sigmoid(z)
  z = 1 ./ (1 + exp(-z));
end