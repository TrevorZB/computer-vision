function stitched_img = stitchImg(varargin)
ransac_n = 100;
ransac_eps = 1;

center = cell2mat(varargin(1));

for i = 2 : size(varargin, 2)
    pan = cell2mat(varargin(i));
    [xs, xd] = genSIFTMatches(pan, center);
    [inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);

    top_left = H_3x3 * [0 ; 0 ; 1];
    top_left = top_left ./ top_left(3);
    top_left = top_left(1:2);

    bottom_left = H_3x3 * [0 ; size(pan, 1) ; 1];
    bottom_left = bottom_left ./ bottom_left(3);
    bottom_left = bottom_left(1:2);

    top_right = H_3x3 * [size(pan, 2) ; 0 ; 1];
    top_right = top_right ./ top_right(3);
    top_right = top_right(1:2);

    bottom_right = H_3x3 * [size(pan, 2) ; size(pan, 1) ; 1];
    bottom_right = bottom_right ./ bottom_right(3);
    bottom_right = bottom_right(1:2);

    bound_left = min([ bottom_left(1) top_left(1) 0 ]);
    bound_right = max([ bottom_right(1) top_right(1) size(center, 2) ]);
    bound_bottom = max([ bottom_left(2) bottom_right(2) size(center, 1) ]);
    bound_top = min([ top_left(2) top_right(2) 0 ]);

    pad_left = ceil(0 - bound_left);
    pad_right = ceil(bound_right - size(center, 2));
    pad_bottom = ceil(bound_bottom - size(center, 1));
    pad_top = ceil(0 - bound_top);

    center = [zeros(pad_bottom, size(center, 2), 3) ; center ; zeros(pad_top, size(center, 2), 3)];
    center = [zeros(size(center, 1), pad_left, 3),  center zeros(size(center, 1), pad_right, 3)];

    dest_canvas_width_height = [size(center, 2), size(center, 1)];

    [xs, xd] = genSIFTMatches(pan, center);
    [inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);

    % Warp the portrait image
    [dest_mask, dest_img] = backwardWarpImg(pan, inv(H_3x3), dest_canvas_width_height);

    center_gray = rgb2gray(center);
    center_mask = (center_gray ~= 0);

    result = blendImagePair(center, center_mask, dest_img, dest_mask, "blend");
    center = result;

end

stitched_img = result;

end






