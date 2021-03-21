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
    % fish and horse are uint8, have slightly different implementation
    if isa(wrapped_imgd(1,1,1), 'uint8')
        % create blend version of destination image
        mask_d = 1 - maskd;
        weight_d = bwdist(mask_d);
        weight_d = weight_d ./ max(weight_d, [], 'all');
        blend_d = uint8(double(wrapped_imgd) .* weight_d);

        % create blend version of source image
        mask_s = 1 - masks;
        weight_s = bwdist(mask_s);
        weight_s = weight_s ./ max(weight_s, [], 'all');
        blend_s = uint8(double(wrapped_imgs) .* weight_s);
        
        % combine the two blends with the weights
        i_blend = blend_d + blend_s;
        i_blend = double(i_blend) ./ (weight_d + weight_s);
        i_blend = uint8(i_blend);
        out = i_blend;
    % mountain images are single, slightly different implementation
    else
        % create blend version of destination image
        mask_d = 1 - maskd;
        weight_d = bwdist(mask_d);
        weight_d = weight_d ./ max(weight_d, [], 'all');
        blend_d = wrapped_imgd .* weight_d;

        % create blend version of source image
        mask_s = 1 - masks;
        weight_s = bwdist(mask_s);
        weight_s = weight_s ./ max(weight_s, [], 'all');
        blend_s = wrapped_imgs .* weight_s;

        % combine the two blends with the weights
        i_blend = blend_d + blend_s;
        i_blend = i_blend ./ (weight_d + weight_s);
        out = i_blend;
    end
end
%save the output image
out_img = out;
end
