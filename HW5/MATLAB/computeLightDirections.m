function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)

light_dirs = zeros(5, 3);

for i = 1 : size(img_cell)

    img = cell2mat(img_cell(i));
    max_inten = max(img, [], 'all');
    [rows cols] = find(img == max_inten);

    mid = floor(size(rows, 1) / 2);
    x = cols(mid);
    y = rows(mid);

    coords = [x y];
    coords = coords - floor(center);

    x_pix = coords(1);
    y_pix = coords(2);

    z_pix = floor(sqrt(radius^2 - (x_pix)^2 - (y_pix)^2));
    coords = [x_pix y_pix z_pix];
    coords = coords * cast(max_inten, 'double');
    light_dirs(i, :) = coords;

end

light_dirs_5x3 = light_dirs;

end
