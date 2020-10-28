 filex = imread(ChestXray.png)
 h = [-1 0 1;-1 0 1; -1 0 1]
 cr = imfilter(filex,h,'corr')
 cv= imfilter(filex,h,'conv')
 imshow([cv,cr,filex])