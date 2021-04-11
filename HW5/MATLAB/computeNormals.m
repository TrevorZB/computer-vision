function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)
albedo_img = zeros(size(mask, 1), size(mask, 2));
normals = zeros(size(mask, 1), size(mask, 2), 3);
normals(:,:,3) = 1;

for j = 1 : size(mask, 1)
    for i = 1 : size(mask, 2)
        if (mask(j, i) ~= 0)
            intensities = zeros(5, 1);
            for k = 1 : size(img_cell, 1)
                image = cell2mat(img_cell(k));
                intensities(k) = image(j, i);
            end
            N = inv(transpose(light_dirs)*light_dirs)*transpose(light_dirs)*double(intensities);
            normal = norm(N);
            n = N ./ normal;
            normals(j, i, :) = n;
            albedo = normal .* pi;
            albedo_img(j, i) = albedo;
        end
    end
end
albedo_img = rescale(albedo_img);
