function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

width = dest_canvas_width_height(1);
height = dest_canvas_width_height(2);

% meshgrid used to create grid of x,y coordinates
[xgrid ygrid] = meshgrid(1:width, 1:height);
coords = [xgrid(:) ygrid(:)];
coords = [coords ones(height * width, 1)];
coords = coords';

% finds the coords on the src image, converts back to cartesian
coords = resultToSrc_H * coords;
coords(1,:) = coords(1,:) ./ coords(3,:);
coords(2,:) = coords(2,:) ./ coords(3,:);
coords = coords(1:2,:);

% have to interp2 for each of the three color channels
img(:,:,1) = interp2(src_img(:,:,1), coords(1,:), coords(2,:));
img(:,:,2) = interp2(src_img(:,:,2), coords(1,:), coords(2,:));
img(:,:,3) = interp2(src_img(:,:,3), coords(1,:), coords(2,:));

% reshape into correct image dimensions
img = reshape(img, height, width, 3);

% get rid of NaN
img(isnan(img)) = 0;

gray_img = rgb2gray(img);
b_w = (gray_img ~= 0);

result_img = img;
mask = b_w;

end
