function ret = debe_parar(u, b, intervalos)
h = 1 / intervalos;
condA = 16 * sin(pi * h)^2;
normAinv = 8 * sin(pi * h / 2)^2;

% A = gen_matriz(intervalos);
Au = aplicar_matriz(u, intervalos);

norma_resta = norm(b - Au);

prod1 = normAinv * norma_resta;
prod2 = condA * norma_resta / norm(b);

ret = prod1 <= 1e-8 || prod2 <= 1e-8;

% max(abs(Au - A*u))
end



function Au = aplicar_matriz(u, intervalos)
n = intervalos - 1;
Au = zeros(size(u));

% Primer bloque
% Este bloque tiene la forma:
% [A -I 0 ... 0]

Au(1 : n) = 4 * u(1 : n) - u(n+1 : 2*n);
Au(1 : n-1) = Au(1 : n-1) - u(2 : n);
Au(2 : n) = Au(2 : n) - u(1 : n - 1);


% Bloques intermedios
% Estos bloques tienen la forma:
% [ 0 ... 0 -I A -I 0 ... 0]

for k = 1 : (n-2)
    Au(n*k + 1 : n*(k+1)) = 4 * u(n*k + 1 : n*(k+1)) ...
        - u(n*(k-1) + 1 : n*k) - u(n*(k+1) + 1 : n*(k+2));

    Au(n*k+1 : n*(k+1)-1) = Au(n*k+1 : n*(k+1)-1) - u(n*k+2 : n*(k+1));

    Au(n*k+2 : n*(k+1)) = Au(n*k+2 : n*(k+1)) - u(n*k+1 : n*(k+1)-1);
end


% Ultimo bloque
% Este bloque tiene la forma:
% [0 ... 0 -I A]

Au(n*(n-1)+1 : n^2) = 4 * u(n*(n-1)+1 : n^2) - u(n*(n-2)+1 : n*(n-1));
Au(n*(n-1)+1 : n^2-1) = Au(n*(n-1)+1 : n^2-1) - u(n*(n-1)+2 : n^2);
Au(n*(n-1)+2 : n^2) = Au(n*(n-1)+2 : n^2) - u(n*(n-1)+1 : n^2-1);

end