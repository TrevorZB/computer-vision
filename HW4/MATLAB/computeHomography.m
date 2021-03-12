function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)
A = zeros(2 * size(src_pts_nx2, 1), 9); % pre-allocate A matrix

for i = 1 : size(src_pts_nx2, 1)
    x_s = src_pts_nx2(i, 1);
    y_s = src_pts_nx2(i, 2);
    x_d = dest_pts_nx2(i, 1);
    y_d = dest_pts_nx2(i, 2);
    
    A(2*i-1,:) = [x_s y_s  1 0 0 0 -x_d*x_s -x_d*y_s -x_d];
    A(2*i,:) = [0 0 0 x_s y_s 1 -y_d*x_s -y_d*y_s -y_d];
end

[V,D] = eig(A'*A);
diagonal = diag(D);
[d,ind] = sort(diagonal);
h = V(:,ind(1));
h = reshape(h, [3 3])';
H_3x3 = h;

end
