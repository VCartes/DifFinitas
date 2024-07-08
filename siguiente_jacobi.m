% Algoritmo que computa la siguiente iteración del método de Jacobi sin
% necesidad de utilizar matrices. Esto se puede hacer gracias a la
% simplicidad de la matriz del método.


function u = siguiente_jacobi(anterior, b, intervalos)
n = intervalos - 1;
u = zeros([n^2, 1]);


% Primer bloque
% Este bloque tiene la forma:
% [A -I 0 ... 0]

u(1 : n) = 1/4 * (b(1 : n) + anterior(n + 1 : 2*n));

u(1 : n-1) = u(1 : n-1) + 1/4 * (anterior(2 : n));
u(2 : n) = u(2 : n) + 1/4 * (anterior(1 : n-1));


% Bloques intermedios
% Estos bloques tienen la forma:
% [ 0 ... 0 -I A -I 0 ... 0]

for k = 1 : (n-2)
    u(n*k + 1 : n*(k+1)) = 1/4 * (b(n*k + 1 : n*(k+1)) ...
        + anterior(n*(k-1) + 1 : n*k) + anterior(n*(k+1) + 1 : n*(k+2)));

    u(n*k+1 : n*(k+1)-1) = u(n*k+1 : n*(k+1)-1) ...
        + 1/4 * (anterior(n*k+2 : n*(k+1)));
    u(n*k+2 : n*(k+1)) = u(n*k+2 : n*(k+1)) ...
        + 1/4 * (anterior(n*k+1 : n*(k+1)-1));
end


% Ultimo bloque
% Este bloque tiene la forma:
% [0 ... 0 -I A]

u(n*(n-1)+1 : n^2) = 1/4 * (b(n*(n-1)+1 : n^2) ...
    + anterior(n*(n-2)+1 : n*(n-1)));

u(n*(n-1)+1 : n^2-1) = u(n*(n-1)+1 : n^2-1) ...
    + 1/4 * (anterior(n*(n-1)+2 : n^2));
u(n*(n-1)+2 : n^2) = u(n*(n-1)+2 : n^2) ...
    + 1/4 * (anterior(n*(n-1)+1 : n^2-1));

end