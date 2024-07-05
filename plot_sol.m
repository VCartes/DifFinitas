function plot_sol(sol, f1, f2, f3, f4, intervalos)
h = 1 / intervalos;
n = intervalos - 1;

[X, Y] = meshgrid(0 : h : 1);

Z = zeros(size(X));
Z(:, 1) = f1;
Z(end, :) = f2;
Z(:, end) = f3;
Z(1, :) = f4;

Z(2 : end-1, 2 : end-1) = reshape(sol, [n, n]);

% surf(X, Y, Z, EdgeColor="none");
surf(X, Y, Z);

% % figure
% hold on
% g = @(x, y) exp(pi * y) .* cos(pi * x) + 20 * exp(-pi * y) .* cos(pi * x);
% U = g(X, Y);
% %surf(X, Y, U);
% hold off
% 
% max(max(abs(Z - U)))

end