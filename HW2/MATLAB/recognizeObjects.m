function output_img = recognizeObjects(orig_img, labeled_img, obj_db)
    % calc properties for passed in objects
    [db, out_img] = compute2DProperties(orig_img, labeled_img);
    round_thresh = 0.05; % roundness percent threshold allowed for image recognition
    found_items = []; % save indexes of recognized objects
    
    for i = 1 : size(db, 2) % cycle through all passed in objects
        img_round = db(6, i);
        for j = 1 : size(obj_db, 2) % cycle through all reference objects
            obj_round = obj_db(6, j);
            thresh = obj_round * round_thresh;
            % test if img roundness within threshold of object roundness
            if (img_round > (obj_round - thresh)) && (img_round < (obj_round + thresh))
                found_items = [found_items i]; % add detected object index to array
                break;
            end
        end
    end
    
    fh1 = figure(); % create figure to draw on image
    imshow(orig_img);
    hold on;
    
    for index = 1 : size(found_items, 2) % draw yellow lines along detected object orientations
        i = found_items(1, index);
        x_cent = db(3, i);
        y_cent = db(2, i);
        obj_orient = db(5, i) * pi / 180;
        x2 = x_cent + (50 * cos(obj_orient));
        y2 = y_cent + (50 * sin(obj_orient));
        
        x3 = x_cent + (50 * cos(obj_orient + pi));
        y3 = y_cent + (50 * sin(obj_orient + pi));
        plot([x3 x2], [y3 y2], 'y', 'LineWidth', 2); % plot line
    end
    
    for index = 1 : size(found_items, 2) % draw red dots on centers of objects
        i = found_items(1, index);
        plot(db(3, i), db(2, i), 'r.', 'MarkerSize', 20);
    end
    
    output_img = saveAnnotatedImg(fh1);
 
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
