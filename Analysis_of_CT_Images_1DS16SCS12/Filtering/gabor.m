full_path = 'DICOM images\thyroid5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
%imshow(dicomread_image);
%to convert gray
dicomread_image2 = mat2gray(dicomread_image);
%applying Gabor filter
gb=gabor_fn(1,0.5,0,2,0);
%compute 2D convolution matrix
gt=conv2(dicomread_image2,double(gb),'same');

%show original image
figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show filtered image
subplot(1,3,2);
imshow(gt);
title('Gabor filtered image');
%to calculate PSNR
[peaksnr, snr] = psnr(gt,dicomread_image2);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);


