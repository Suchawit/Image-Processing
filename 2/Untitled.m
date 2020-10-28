N = 3; %// Define size of Gaussian mask
sigma = 0.55; %// Define sigma here

%// Generate Gaussian mask
ind = -floor(N/2) : floor(N/2);
[X Y] = meshgrid(ind, ind);
h = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
h = h / sum(h(:));

%// Convert filter into a column vector
