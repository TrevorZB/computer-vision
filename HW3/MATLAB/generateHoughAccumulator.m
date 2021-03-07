function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
theta_step_size = pi / theta_num_bins;
diagonal = sqrt(size(img, 1)^2 + size(img, 2)^2);
min_rho = -diagonal;
rho_per_bin = floor(2 * diagonal / rho_num_bins);

accumulator = zeros(rho_num_bins, theta_num_bins);

for y = 1 : size(img, 1) % rows
    for x = 1 : size(img, 2) % columns
        if img(y, x) == 255 % edge pixel
            for k = 1 : size(accumulator, 2) % loop through thetas
                theta = theta_step_size * k;
                rho = y * cos(theta) - x * sin(theta); % calc ro
                rho_index = ceil((rho - min_rho) / rho_per_bin);
                if rho_index < 1 % out of bounds checks
                    rho_index = 1;
                end
                if rho_index > size(accumulator, 1) - 1
                    rho_index = size(accumulator, 1) - 1;
                end
                % vote for this bin
                accumulator(rho_index, k) = accumulator(rho_index, k) + 1;
            end 
        end
    end
end

accumulator = rescale(accumulator, 0, 255);
hough_img = accumulator;

end