mask = zeros(size(I));
mask(25:end-25,25:end-25) = 1;
bw = activecontour(I,mask,300);
figure
imshow(bw)
title('Segmented Image')