function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)
albedo_img = zeros(size(mask, 1), size(mask, 2));
normals = zeros(size(mask, 1), size(mask, 2), 3);
normals(:,:,3) = 1;

for j = 1 : size(mask, 1)
    for i = 1 : size(mask, 2)
        if (mask(j, i) ~= 0)
            intensities = [];
            for k = 1 : size(img_cell, 1)
                image = cell2mat(img_cell(k));
                intensities = [intensities image(j, i)];
            end
            [maxi indices] = maxk(intensities, 3);
            S = zeros(3, 3);
            I = transpose(maxi);
            for k = 1 : 3
                index = indices(1, k);
                s = light_dirs(index,:);
                S(k,:) = s;
            end
            N = inv(S) * double(I);
            normal = norm(N);
            n = N ./ normal;
            normals(j, i, :) = n;
            albedo = normal .* pi;
            albedo_img(j, i) = albedo;
        end
    end
end
albedo_img = rescale(albedo_img);
