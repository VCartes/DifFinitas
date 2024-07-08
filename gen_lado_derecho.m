% Construye el vector del lado derecho utilizado para el método de
% diferencias finitas. Incluye datos de frontera y de la función lado
% derecho.
%
% Es necesario tener precaución con los datos de frontera, los vectores
% con ellos no se alinean perfectamente con el vector de output.

function b = gen_lado_derecho(f, ...
    front1, front2, front3, front4, intervalos)

h = 1 / intervalos;
n = intervalos - 1;
b = zeros([n^2, 1]);

for j = 1 : n
    puntos = 1 : n;
    b(n*(j-1) + 1 : n*j) = h^2 * f(h * puntos, h * j);

    b(n*(j-1) + 1) = b(n*(j-1) + 1) + front4(j + 1);
    b(n*j) = b(n*j) + front2(j + 1);
end

b(1 : n) = b(1 : n) + front1(2 : intervalos);
b(n^2-n+1 : n^2) = b(n^2-n+1 : n^2) + front3(2 : intervalos);
end