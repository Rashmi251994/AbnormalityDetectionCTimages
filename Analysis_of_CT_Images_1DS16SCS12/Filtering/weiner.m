full_path = 'DICOM images\lung1.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);
K = wiener2(dicomread_image2,[5 5]);
figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show filtered image
subplot(1,3,2);
imshow(K);
title('Wiener filtered image');
%to calculate PSNR
[peaksnr, snr] = psnr(K, dicomread_image2);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);