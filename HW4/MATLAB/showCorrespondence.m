function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)

offset = size(orig_img, 2); % horiziontal addition to second image
img = [orig_img warped_img]; % put images side by side
imshow(img);
for i = 1 : size(src_pts_nx2, 1)
    line_x = [src_pts_nx2(i,1) offset+dest_pts_nx2(i,1)];
    line_y = [src_pts_nx2(i,2) dest_pts_nx2(i,2)];
    line(line_x, line_y, 'Color', 'red');
end

end
