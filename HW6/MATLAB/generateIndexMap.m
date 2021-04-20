function index_map = generateIndexMap(gray_stack, w_size)
x_lap = [0 0 0 ; -1 2 -1 ; 0 0 0]; % x dimension laplacian
y_lap = [0 -1 0 ; 0 2 0 ; 0 -1 0]; % y dimension laplacian

for i = 1 : size(gray_stack, 3)
    img = gray_stack(:,:,i);

    img_x = abs(imfilter(img, x_lap)); % modified laplacian in x dimension
    img_y = abs(imfilter(img, y_lap)); % modified laplacian in y dimension

    img = img_x + img_y; % add the modified x and y dimensions together
    img = imfilter(img, ones(w_size*2 + 1)); % sum in a window
    avg_filter = fspecial('disk', 25); % average out noise
    img = imfilter(img, avg_filter); % average out noise
    
    gray_stack(:,:,i) = img;
end

[temp, index_map] = max(gray_stack, [], 3); % find the indices of the maxs

end
