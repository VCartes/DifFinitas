function x = siguiente_jacobi(anterior, b, intervalos)
n = intervalos - 1;
x = zeros([n^2, 1]);


% Primer bloque
% Este bloque tiene la forma:
% [A -I 0 ... 0]

x(1 : n) = 1/4 * (b(1 : n) + anterior(n + 1 : 2*n));

x(1 : n-1) = x(1 : n-1) + 1/4 * (anterior(2 : n));
x(2 : n) = x(2 : n) + 1/4 * (anterior(1 : n-1));


% Bloques intermedios
% Estos bloques tienen la forma:
% [ 0 ... 0 -I A -I 0 ... 0]

for j = 1 : (n-2)
    x(n*j + 1 : n*(j+1)) = 1/4 * (b(n*j + 1 : n*(j+1)) ...
        + anterior(n*(j-1) + 1 : n*j) + anterior(n*(j+1) + 1 : n*(j+2)));

    x(n*j+1 : n*(j+1)-1) = x(n*j+1 : n*(j+1)-1) ...
        + 1/4 * (anterior(n*j+2 : n*(j+1)));
    x(n*j+2 : n*(j+1)) = x(n*j+2 : n*(j+1)) ...
        + 1/4 * (anterior(n*j+1 : n*(j+1)-1));
end


% Ultimo bloque
% Este bloque tiene la forma:
% [0 ... 0 -I A]

x(n*(n-1)+1 : n^2) = 1/4 * (b(n*(n-1)+1 : n^2) ...
    + anterior(n*(n-2)+1 : n*(n-1)));

x(n*(n-1)+1 : n^2-1) = x(n*(n-1)+1 : n^2-1) ...
    + 1/4 * (anterior(n*(n-1)+2 : n^2));
x(n*(n-1)+2 : n^2) = x(n*(n-1)+2 : n^2) ...
    + 1/4 * (anterior(n*(n-1)+1 : n^2-1));

end