full_path = 'DICOM images\thyroid5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);
%K =  imgaussfilt(dicomread_image2, 2);
res = imGaussFilter(dicomread_image2, 17, 3, 0);
figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show filtered image
subplot(1,3,2);
imshow(res);
title('Gaussion filtered image');
[peaksnr, snr] = psnr(dicomread_image2,res);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);