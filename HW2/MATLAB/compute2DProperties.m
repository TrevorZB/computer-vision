function[db, out_img] = compute2DProperties(gray_img, labeled_img)
    num_objects = max(max(labeled_img)); % calc # objects in image
    db = zeros(6, num_objects); % init database to 0s
    areas = zeros(num_objects, 1); % store calculated object areas
    a_primes = zeros(num_objects, 1); % store a` values
    b_primes = zeros(num_objects, 1); % store b` values
    c_primes = zeros(num_objects, 1); % store c` values
    a_s = zeros(num_objects, 1); % store a values
    b_s = zeros(num_objects, 1); % store b values
    c_s = zeros(num_objects, 1); % store c values
    theta_twos = zeros(num_objects, 1); % store theta_two values
    e_maxs = zeros(num_objects, 1); % store e_max values
    
    for i = 1 : size(db, 2)
        db(1, i) = i; % save object labels in database
    end

    % loop through all pixels in the labeled image
    for i = 1 : size(labeled_img, 1)
        for j = 1 : size(labeled_img, 2)
            val = labeled_img(i, j);
            if val > 0
               areas(val) = areas(val) + 1; % calc area
               db(2, val) = db(2, val) + i; % calc row center
               db(3, val) = db(3, val) + j; % calc col center
               a_primes(val) = a_primes(val) + j^2; % calc a`s
               b_primes(val) = b_primes(val) + i * j; % calc b`s
               c_primes(val) = c_primes(val) + i^2; % calc c`s
            end
        end
    end
    
    for i = 1 : size(b_primes, 1)
        b_primes(i) = b_primes(i) * 2; % final calc for b`s
    end
    
    for j = 1 : size(db, 2)
        db(2, j) = db(2, j) / areas(j); % final calc for row center
        db(3, j) = db(3, j) / areas(j); % final calc for col center
    end
    
    for i = 1 : size(a_s, 1)
        cent_x = db(3, i);
        cent_y = db(2, i);
        area = areas(i);       
        a_s(i) = a_s(i) + a_primes(i) - (cent_x^2 * area); % calc a_s
        b_s(i) = b_s(i) + b_primes(i) - 2 * cent_x * cent_y * area; % calc b_s
        c_s(i) = c_s(i) + c_primes(i) - (cent_y^2 * area); % calc c_s
    end
    
    for i = 1 : size(db, 2) % save orientations in db
       db(5, i) = db(5, i) + (atan2(b_s(i), a_s(i) - c_s(i)) / 2); 
    end
    
    for i = 1 : size(db, 2) % save min inertia in db
        theta_one = db(5, i);
        f = a_s(i) * sin(theta_one)^2;
        g = b_s(i) * sin(theta_one) * cos(theta_one);
        h = c_s(i) * cos(theta_one)^2;
        db(4, i) = db(4, i) + f - g + h;
    end
    
    for i = 1 : size(theta_twos, 1) % calc theta_twos
        theta_twos(i) = theta_twos(i) + db(5, i) + (pi / 2); 
    end
    
    for i = 1 : size(e_maxs) % calc E_maxs
        theta_two = theta_twos(i);
        f = a_s(i) * sin(theta_two)^2;
        g = b_s(i) * sin(theta_two) * cos(theta_two);
        h = c_s(i) * cos(theta_two)^2;
        e_maxs(i) = e_maxs(i) + f - g + h;
    end
    
    for i = 1: size(db, 2) % save roundness in database
        db(6, i) = db(6, i) + (db(4, i) / e_maxs(i));
    end
    
    %%%%% draw line
    fh1 = figure();
    imshow(gray_img);
    hold on;

    x2=db(3,1)+(20*cos(db(5,1)));
    y2=db(2,1)+(20*sin(db(5,1)));
    plot([db(3,1) x2],[db(2,1) y2])
    %%%%% draw line
   
    for i = 1 : size(db, 2) % convert orientations to degrees from radians
        db(5, i) = db(5, i) * 180 / pi;
    end
    


    for i = 1 : size(db, 2)
        plot(db(3, i), db(2, i), 'r.', 'MarkerSize', 20);
    end

    % annotated_img = saveAnnotatedImg(fh1);

    % fh3 = figure; imshow(annotated_img);
    
    

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