function mask = computeMask(img_cell)

m = zeros(size(cell2mat(img_cell(1))));

for i = 1 : size(img_cell)
    img = cast(cell2mat(img_cell(i)), 'double');
    m = m + img;
end

m(m > 0) = 1;
mask = m;

end
