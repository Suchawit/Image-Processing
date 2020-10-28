function [NoisyImg,MSE] = AddNLNoise(DicomAddress,NoiseType,NoiseChr)
i = dicomread(DicomAddress);
j = i(:,:,:,1); % read first slide of DCIM File
j = im2double(j);
NoisyImg = imnoise(j,NoiseType,NoiseChr);

imshow([j,NoisyImg]);
    if NoiseType == "speckle"
        imwrite(NoisyImg, 'Speckle.png');
    elseif NoiseType == "salt & pepper"
        imwrite(NoisyImg, 'Salt&pepper.png');
    end
plot([j(:,1,1) NoisyImg(:,1:1)])
legend('Original Signal','Signal with Noisy')
MSE = immse(j,NoisyImg);
end
