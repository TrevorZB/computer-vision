function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
theta_step_size = pi / size(hough_img, 2);
rho_num_bins = size(hough_img, 1);
diagonal = sqrt(size(orig_img, 1)^2 + size(orig_img, 2)^2);
min_rho = -diagonal;
rho_per_bin = floor(2 * diagonal / rho_num_bins);

theta_indexes = [];
rho_indexes = [];

% recreate edge image
canny_thresh = 0.25;
edge_img = edge(orig_img, 'canny', canny_thresh);

for y = 1 : size(hough_img, 1) % rows
    for x = 1 : size(hough_img, 2) % columns
        val = hough_img(y, x); % number of votes
        if val > hough_threshold % apply threshold
            theta_indexes = [theta_indexes, x]; % save indexes
            rho_indexes = [rho_indexes, y];
        end
    end
end

% used to store the endpoints of the lines above the hough_threshold
min_y = zeros(1, size(theta_indexes, 2)) + size(orig_img, 1);
max_y = zeros(1, size(theta_indexes, 2));

% store corresponding x value of the above y values
min_x = zeros(1, size(theta_indexes, 2));
max_x = zeros(1, size(theta_indexes, 2));

% find pixels that voted for the lines above the hough_threshold
for y = 1 : size(edge_img, 1) % rows
    for x = 1 : size(edge_img, 2) % columns
        if edge_img(y, x) == 1 % edge pixel
            for k = 1 : size(hough_img, 2) % loop through thetas
                theta = theta_step_size * k;
                rho = y * cos(theta) - x * sin(theta); % calc ro
                rho_index = ceil((rho - min_rho) / rho_per_bin);
                if rho_index < 1
                    rho_index = 1;
                end
                if rho_index > size(hough_img, 1) - 1
                    rho_index = size(hough_img, 1) - 1;
                end
                % loop through indexes, see if they match this pixel's vote
                for i = 1 : size(theta_indexes, 2)
                    if rho_indexes(i) == rho_index && theta_indexes(i) == k
                        if y < min_y(i)
                            min_y(i) = y; % minimum endpoint
                            min_x(i) = x;
                        end
                        if y > max_y(i)
                            max_y(i) = y; % maximum endpoint
                            max_x(i) = x;
                        end
                    end
                end
            end 
        end
    end
end

fh1 = figure(); % create figure to draw on image
imshow(orig_img);
hold on;

% plot lines connecting the saved endpoints
for i = 1 : size(min_y, 2)
    plot([min_x(i) max_x(i)], [min_y(i) max_y(i)], 'g');
end



end
