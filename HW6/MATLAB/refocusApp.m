function refocusApp(rgb_stack, depth_map)

r = randi([1 size(rgb_stack, 3)/3], 1);
img = rgb_stack(:,:,r*3-2:r*3);
imshow(img);
[x, y] = ginput(1);
i = depth_map(ceil(y), ceil(x));
new_img = rgb_stack(:,:,i*3-2:i*3);
imshow(new_img);

end
