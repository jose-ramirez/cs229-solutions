indices = log_phi_k1 - log_phi_k0;
[values, inds] = sort(indices, 'descend');
token_list = strsplit(tokenlist, ' ');
indicators = token_list(inds(1:5))