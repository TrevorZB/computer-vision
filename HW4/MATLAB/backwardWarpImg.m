function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

width = dest_canvas_width_height(1);
height = dest_canvas_width_height(2);

% meshgrid used to create grid of x,y,1 coordinates
[xgrid ygrid] = meshgrid(1:width, 1:height);
coords = [xgrid(:) ygrid(:)];
coords = [coords ones(height * width, 1)];
coords = coords';

% iterate through coords, convert to src pair through homography
for i = 1 : size(coords, 2)
    coord = coords(:,i);
    coord = resultToSrc_H * coord;
    coord(1) = coord(1) / coord(3);
    coord(2) = coord(2) / coord(3);
    coords(:,i) = coord;
end

% have to interp2 for each of the three color channels
img(:,:,1) = interp2(src_img(:,:,1), coords(1,:), coords(2,:));
img(:,:,2) = interp2(src_img(:,:,2), coords(1,:), coords(2,:));
img(:,:,3) = interp2(src_img(:,:,3), coords(1,:), coords(2,:));

% reshape into correct image dimensions
img = reshape(img, height, width, 3);

% get rid of NaN
for x = 1 : size(img, 2)
    for y = 1 : size(img, 1)
        if isnan(img(y, x))
            img(y, x, :) = 0;
        end
    end
end

% convert to binary mask
gray_img = rgb2gray(img);
b_w = (gray_img ~= 0);

% save outputs
result_img = img;
mask = b_w;

end
