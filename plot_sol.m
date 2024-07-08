function plot_sol(sol, f1, f2, f3, f4, intervalos)
h = 1 / intervalos;
n = intervalos - 1;

[X, Y] = meshgrid(0 : h : 1);
Z = zeros(size(X));

% Incluir datos de frontera
Z(1, :) = f1;
Z(:, end) = f2;
Z(end, :) = f3;
Z(:, 1) = f4;

% Incluir datos del interior del conjunto, es necesario trasponer
% debido a la forma del vector de incógnitas
Z(2 : end-1, 2 : end-1) = reshape(sol, [n, n])';

% Plot de la gráfica
surf(X, Y, Z, EdgeAlpha=0);

end