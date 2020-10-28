function kernel = myGaussian(wsize, sigma)

i = -floor(wsize/2) : floor(wsize/2);
[X, Y] = meshgrid(i, i); % returns 2-D grid coordinates based on the coordinates contained in vectors x and y
kernel = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
kernel = kernel / sum(kernel(:));
end

