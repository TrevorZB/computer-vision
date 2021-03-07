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

% draw the calculated lines
for i = 1 : size(thetas, 2)
    theta = thetas(i);
    rho = rhos(i);
    m = sin(theta) / cos(theta);
    b = rho / cos(theta);
    x = 1:size(orig_img, 2);
    y = m*x + b;
    line(x, y, 'Color', 'green', 'LineWidth', 2);
end

line_detected_img = saveAnnotatedImg(fh1);

end

% copied from demoMATLABTricksFun.m
function annotated_img = saveAnnotatedImg(fh)
figure(fh); % Shift the focus back to the figure fh

% The figure needs to be undocked
set(fh, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size. 
frame = getframe(fh);
frame = getframe(fh);
pause(0.5); 
% Because getframe tries to perform a screen capture. it somehow 
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround. 
annotated_img = frame.cdata;
end

