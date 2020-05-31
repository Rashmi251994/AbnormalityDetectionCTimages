function [dilateimg, lungimg] = cancerDetector(res)

%% use global image thresholding to find the edge
% generate the thresholded image
[segimg, ~] = otsu(res,2);
% segimg(find(segimg == 1)) = 0;
segimg(find(segimg == 2)) = 0;

figure
imshow(segimg), title('seg without fill')
% implement morphological reconstruction to 
% find the lung region in the image
inborderimg = imclearborder(segimg);

% erode the image
SE = strel('disk', 4);
erodeimg = imerode(inborderimg, SE);

% dilate the image to restore the nodules
SE = strel('disk', 4);
dilateimg = imdilate(erodeimg, SE);

% store the lung image for post process
lungimg = dilateimg;
%figure
%imshow(lungimg);
end