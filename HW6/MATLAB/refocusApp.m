function refocusApp(rgb_stack, depth_map)

r = randi([1 size(rgb_stack, 3)/3], 1);
img = rgb_stack(:,:,r*3-2:r*3);

while 1 == 1
    imshow(img);
    [x, y] = ginput(1);
    if x < 1 || y < 1 || x > size(img, 2) || y > size(img, 1)
        break;
    end
    i = depth_map(ceil(y), ceil(x));
    img = rgb_stack(:,:,i*3-2:i*3);
end

close;

end
