% Algoritmo basado en el libro de Saad que calcula la siguiente iteración
% del método de SOR sin necesidad de construir la matriz de iteración.
%
% Se decidió hacerlo de esta manera por temas de rendimiento y gracias
% A la simple forma de la matriz tridiagonal del método.


function u = siguiente_sor(anterior, b, w, intervalos)
n = intervalos - 1;
u = zeros([n^2, 1]);


% Primer bloque
% Este bloque tiene la forma:
% [A -I 0 ... 0]

u(1) = w/4 * (b(1) + anterior(2) + anterior(n + 1)) + (1-w)*anterior(1);

for j = 2 : n-1
    u(j) = w/4 * (b(j) + u(j - 1) + anterior(j + 1) + anterior(n + j)) ...
        + (1-w)*anterior(j);
end

u(n) = w/4 * (b(n) + u(n - 1) + anterior(2*n)) + (1-w)*anterior(n);


% Bloques intermedios
% Estos bloques tienen la forma:
% [ 0 ... 0 -I A -I 0 ... 0]

for k = 1 : (n-2)
    u(n*k + 1) = w/4 * (b(n*k + 1) + u(n*(k-1) + 1) + anterior(n*k + 2) ...
        + anterior(n*(k+1) + 1)) + (1-w)*anterior(n*k + 1);

    for j = 2 : n-1
        u(n*k + j) = w/4 * (b(n*k + j) + u(n*(k-1) + j) + u(n*k + j-1) ...
            + anterior(n*k + j+1) + anterior(n*(k+1) + j)) ...
            + (1-w)*anterior(n*k + j);
    end

    u(n*(k+1)) = w/4 * (b(n*(k+1)) + u(n*k) + u(n*(k+1) - 1) ...
        + anterior(n*(k+2))) + (1-w)*anterior(n*(k+1));
end


% Ultimo bloque
% Este bloque tiene la forma:
% [0 ... 0 -I A]

u(n*(n-1) + 1) = w/4 * (b(n*(n-1) + 1) + u(n*(n-2) + 1) ...
    + anterior(n*(n-1) + 2)) + (1-w)*anterior(n*(n-1) + 1);

for j = 2 : n-1
    u(n*(n-1) + j) = w/4 * (b(n*(n-1) + j) + u(n*(n-2) + j) ...
        + u(n*(n-1) + j-1) + anterior(n*(n-1) + j+1)) ...
        + (1-w)*anterior(n*(n-1) + j);
end

u(n^2) = w/4 * (b(n^2) + u(n*(n-1)) + u(n^2 - 1)) ...
    + (1-w)*anterior(n^2);

end