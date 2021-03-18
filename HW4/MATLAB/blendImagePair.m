function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
out = [];

if strcmp(mode, 'overlay')
    out = wrapped_imgs;
    for y = 1 : size(maskd, 1)
        for x = 1 : size(maskd, 2)
            if maskd(y, x) > 0
                out(y, x, :) = wrapped_imgd(y, x, :);
            end
        end
    end
elseif strcmp(mode, 'blend')
    mask_d = 1 - maskd;
    weight_d = bwdist(mask_d);
    weight_d = weight_d ./ max(weight_d, [], 'all');
    blend_d = uint8(double(wrapped_imgd) .* weight_d);
    
    mask_s = 1 - masks;
    weight_s = bwdist(mask_s);
    weight_s = weight_s ./ max(weight_s, [], 'all');
    blend_s = uint8(double(wrapped_imgs) .* weight_s);
    
    i_blend = blend_d + blend_s;
    i_blend = double(i_blend) ./ (weight_d + weight_s);
    i_blend = uint8(i_blend);
    out = i_blend;
end
out_img = out;
end
