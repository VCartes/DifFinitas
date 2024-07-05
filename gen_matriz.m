function A = gen_matriz(intervalos)
n = intervalos - 1;
A = zeros(n^2);

for i = 1 : n
    A(n*(i-1)+1 : n*i, n*(i-1)+1 : n*i) = -diag(ones([1, n-1]), 1) ...
        - diag(ones([1, n-1]), -1);
end

A = A + 4 * eye(n^2) - diag(ones([1, n^2-n]), n) ...
    - diag(ones([1, n^2-n]), -n);

end