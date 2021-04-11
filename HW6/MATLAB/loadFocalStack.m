function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)

rgb_stack = 1;
gray_stack = 1;
first = 1;

images = dir(focal_stack_dir);

for i = 1 : size(images)
    name = images(i).name;
    if strcmp(name, '.') || strcmp(name, '..')
        continue;
    end
    name = strcat(focal_stack_dir, "/", name); 
    image = imread(name);
    if first == 1
        rgb_stack = image;
        gray_stack = rgb2gray(image);
        first = 0;
    else
        rgb_stack = cat(3, rgb_stack, image);
        gray_stack = cat(3, gray_stack, rgb2gray(image));
    end
end

end
