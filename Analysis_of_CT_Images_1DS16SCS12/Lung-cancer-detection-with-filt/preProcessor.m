function res = preProcessor()

%% read the image file and preprocess
% 032 is healthy
path = 'DICOM images\image6';

% read the dcm image file
img = dicomread(path);
%full_path = 'resources\1.3.6.1.4.1.14519.5.2.1.6279.6001.179049373636438705059720603192'; 
%dicominfo_image = dicominfo(full_path);
%img = dicomreadVolume(full_path);

% this is how to show the dcm image
% imshow(img, [])

% transfer the rgb image to grey scale
% greyimg = rgb2gray(img);
greyimg = im2uint8(img);
figure
imshow(greyimg), title('Original image');
K = medfilt2(greyimg,[3 3]);
J = imGaussFilter(K, 3, 3, 0);
res = adapthisteq(J,'cliplimit',0.01,'Distribution','rayleigh');

figure
imshow(res),title('Filtered image');
% calculate the average grey level
avgimg = mean(double(reshape(res, [], 1)));


% %% use gabor filter to process the ct image
% % set the parameters
% lambda  = 8;
% theta   = 0;
% psi     = [0 pi/2];
% gamma   = 0.5;
% bw      = 1;
% N       = 8;
% img_in = greyimg;
% % img_in(:,:,2:3) = [];   % discard redundant channels, it's gray anyway
% img_out = zeros(size(img_in,1), size(img_in,2), N);
% for n=1:N
%     gb = gaborfilter(bw,gamma,psi(1),lambda,theta)...
%         + 1i * gaborfilter(bw,gamma,psi(2),lambda,theta);
%     % gb is the n-th gabor filter
%     img_out(:,:,n) = imfilter(img_in, gb, 'symmetric');
%     % filter output to the n-th channel
%     theta = theta + 2*pi/N;
%     % next orientation
% end
% img_out_disp = sum(abs(img_out).^2, 3).^0.5;
% % default superposition method, L2-norm
% img_out_disp = img_out_disp./max(img_out_disp(:));

end