function s = equalization(r)
[m, n] = size(r);
gray = zeros(256, 1);

for i = 1:m
    for j = 1:n
      gray(r(i,j)+1) = gray(r(i,j)+1) + 1;
    end
end

fun = zeros(256, 1);
sum = 0;
for i = 1:256
    sum = sum + gray(i);
    fun(i) = sum*255/m/n;
end

new = zeros(m, n);
for i = 1:m
    for j = 1:n
        new(i, j) = fun(r(i, j)+1);
    end
end
s = uint8(new);