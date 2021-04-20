function refocusApp(rgb_stack, depth_map)

r = randi([1 size(rgb_stack, 3)/3], 1); % pick random image to start
img = rgb_stack(:,:,r*3-2:r*3); % grab all 3 rgb parts of image

while 1 == 1
    imshow(img);
    [x, y] = ginput(1);
    if x < 1 || y < 1 || x > size(img, 2) || y > size(img, 1)
        break; % click outside of image, break loop
    end
    i = depth_map(ceil(y), ceil(x));
    img = rgb_stack(:,:,i*3-2:i*3); % find the image and display it
end

close; % close imshow figure

end
