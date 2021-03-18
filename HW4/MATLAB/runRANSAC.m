function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)

h_best = [];
inliers_best = [];

for k = 1 : ransac_n
    i = randi(size(Xs, 1), 4, 1);
    s = [Xs(i(1),:) ; Xs(i(2),:) ; Xs(i(3),:) ; Xs(i(4),:)];
    d = [Xd(i(1),:) ; Xd(i(2),:) ; Xd(i(3),:) ; Xd(i(4),:)];
    h = computeHomography(s, d);

    inliers = [];
    for j = 1 : size(Xs, 1)
        d_pix = [Xd(j, 1) Xd(j, 2)];
        s_pix = [Xs(j, 1) ; Xs(j, 2) ; 1];
        result = h * s_pix;
        result = result ./ result(3);
        result = [result(1) result(2)];
        if norm(result - d_pix) < eps
            inliers = [inliers j];
        end
    end
    if size(inliers, 2) > size(inliers_best, 2)
        inliers_best = inliers;
        h_best = h;
    end
end

inliers_id = inliers_best;
H = h_best;

end
