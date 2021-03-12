function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)
d_pts = zeros(size(src_pts_nx2, 1), 2);

for i = 1 : size(src_pts_nx2, 1)
    pix = [src_pts_nx2(i,1) ; src_pts_nx2(i,2) ; 1];
    h_pix = H_3x3 * pix;
    d_pix = h_pix / h_pix(3);
    d_pts(i,:) = d_pix(1:2)';
end

dest_pts_nx2 = d_pts;

end
