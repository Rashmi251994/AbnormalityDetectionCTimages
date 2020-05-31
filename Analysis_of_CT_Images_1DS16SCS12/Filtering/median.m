full_path = 'DICOM images\blader5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);
K = medfilt2(dicomread_image2,[3 3]);
figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show filtered image
subplot(1,3,2);
imshow(K);
title('Median filtered image');
%to calculate PSNR
[peaksnr, snr] = psnr(K,dicomread_image2);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);