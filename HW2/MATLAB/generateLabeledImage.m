function labeled_img = generateLabeledImage(gray_img, threshold)   
    % create bw image with threshold (0.45 for threshold seems good)
    bw_img = im2bw(gray_img, threshold);
    
    % return the labeled image
    labeled_img = bwlabel(bw_img);
end
