N = 5;
im_pad = padarray(I, [floor(N/2) floor(N/2)]);
im_col = im2col(im_pad, [N N], 'sliding');
sorted_cols = sort(im_col, 1, 'ascend');
med_vector = sorted_cols(floor(N*N/2) + 1, :);
out = col2im(med_vector, [N N], size(im_pad), 'sliding');
subplot(1,2,1);
imshow(out);
subplot(1,2,2);
imshow(new);