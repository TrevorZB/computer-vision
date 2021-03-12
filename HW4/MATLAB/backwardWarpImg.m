function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

for y = 1 : size(src_img, 1)
    for x = 1 : size(src_img, 2)
        pix_val = src_img(y, x);
        pix = [x ; y ; 1];
        
    end
end


% for i = 1 : size(src_pts_nx2, 1)
%     pix = [src_pts_nx2(i,1) ; src_pts_nx2(i,2) ; 1];
%     h_pix = H_3x3 * pix;
%     d_pix = h_pix / h_pix(3);
%     d_pts(i,:) = d_pix(1:2)';
% end

end
