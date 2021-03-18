function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

width = size(src_img, 2);
height = size(src_img, 1);
img = zeros(dest_canvas_width_height(2), dest_canvas_width_height(1), 3);

for y = 1 : size(img, 1)
    for x = 1 : size(img, 2)
        pix = [x ; y ; 1];
        pix = resultToSrc_H * pix;
        pix = pix ./ pix(3);
        pix = ceil(pix);
        if pix(1) > 1 && pix(1) < width
            if pix(2) > 1 && pix(2) < height
                pix_val = src_img(pix(2), pix(1), :);
                img(y, x, :) = pix_val;
            end
        end
    end
end

gray_img = rgb2gray(img);
b_w = (gray_img ~= 0);

result_img = img;
mask = b_w;

end
