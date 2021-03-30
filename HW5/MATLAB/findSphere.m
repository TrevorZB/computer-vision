function [center, radius] = findSphere(img)

img = im2bw(img, 0.001);
s = regionprops(img, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
diameter = mean([s.MajorAxisLength s.MinorAxisLength],2);

center = s.Centroid;
radius = diameter/2;

end
