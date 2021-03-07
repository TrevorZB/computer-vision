function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
theta_step_size = pi / size(hough_img, 2);
rho_num_bins = size(hough_img, 1);
diagonal = sqrt(size(orig_img, 1)^2 + size(orig_img, 2)^2);
min_rho = -diagonal;
rho_per_bin = floor(2 * diagonal / rho_num_bins);

thetas = [];
rhos = [];

for y = 1 : size(hough_img, 1) % rows
    for x = 1 : size(hough_img, 2) % columns
        val = hough_img(y, x); % number of votes
        if val > hough_threshold % apply threshold
            theta = theta_step_size * x;
            rho = y * rho_per_bin + min_rho;
            thetas = [thetas, theta];
            rhos = [rhos, rho];
        end
    end
end

fh1 = figure(); % create figure to draw on image
imshow(orig_img);
hold on;

for i = 1 : size(thetas, 2)
    theta = thetas(i);
    rho = rhos(i);
    m = sin(theta) / cos(theta);
    b = rho / cos(theta);
    x = 1:size(orig_img, 2);
    y = m*x + b;
    line(x, y);
end

end
