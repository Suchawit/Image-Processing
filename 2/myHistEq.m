function [imgHE, orgHist, heHist] = myHistEq(img)
img = rgb2gray(img);
img = uint8(img);
[rows,columns] = size(img);
imgHE = uint8(zeros(rows,columns));
pixelNumber = rows*columns;
fre = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cummlative = zeros(256,1);
outpic = zeros(256,1);
% histrogram
for i = 1:1:rows
    for j = 1:1:columns
        val = img(i,j);
        fre(val+1) = fre(val+1)+1;
        pdf(val+1) = fre(val+1)/pixelNumber;
    end
end

sum =0;
intensity = 255;

for i = 1:1:size(pdf)
    sum =sum +fre(i);
    cummlative(i) = sum;
    cdf(i) = cummlative(i)/ pixelNumber;
    outpic(i) = round(cdf(i) * intensity);
end


for i = 1:1:rows
    for j = 1:1:columns
        imgHE(i,j) = outpic(img(i,j) + 1);
    end
end
orgHist = pdf;
heHist = cdf;
subplot(2,2,1),imshow(img),title('LowContrast');
subplot(2,2,2),imshow(imgHE),title('HistogramEqualized');
subplot(2,2,3),bar(pdf),title('OriginalHistogram');
subplot(2,2,4),bar(cdf),title('EqualizedHistogram');


end

