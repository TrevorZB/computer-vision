function index_map = generateIndexMap(gray_stack, w_size)
x_lap = [0 0 0 ; -1 2 -1 ; 0 0 0];
y_lap = [0 -1 0 ; 0 2 0 ; 0 -1 0];

for i = 1 : size(gray_stack, 3)
    img = gray_stack(:,:,i);

    img_x = abs(imfilter(img, x_lap));
    img_y = abs(imfilter(img, y_lap));

    img = img_x + img_y;
    img = imfilter(img, ones(w_size*2 + 1));
    avg_filter = fspecial('average', w_size*2 + 1);
    img = imfilter(img, avg_filter);
    
    gray_stack(:,:,i) = img;
end

[temp, index_map] = max(gray_stack, [], 3);

end
