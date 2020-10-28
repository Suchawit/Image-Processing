function kernel = myLoG(wsize, sigma)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
i = -floor(wsize/2) : floor(wsize/2);
[X, Y] = meshgrid(i, i); % returns 2-D grid coordinates based on the coordinates contained in vectors x and y
kernel = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
kernel_L = kernel.*(X.^2 + Y.^2-2*sigma^2)/(sigma^4*sum(kernel(:)));
kernel = kernel_L - sum(kernel_L(:))/wsize^2; % make the filter sum to zero

end

