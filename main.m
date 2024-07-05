close all
clearvars
% TODO : PROBLEMAS CON EL ORDEN DE LOS VECTORES USAR GIT

% f = @(x, y) 0 * x .* y + 1;
% g = @(x, y) 0 *x .* y;

% f = @(x, y) 200*(x.^2 + y.^2);
% g = @(x, y) exp(pi * y) * cos(pi * x) + 20 * exp(-pi * y) * cos(pi * x);

f = @(x, y) -8*pi^2 * sin(2*pi*x) .* sin(2*pi*y);
g = @(x, y) 0.*x.*y;

intervalos = 75;

[front1, front2, front3, front4] = gen_datos_frontera(g, intervalos);

lado_derecho = gen_lado_derecho(f, front1, front2, front3, ...
   front4, intervalos);

% matriz = gen_matriz(intervalos);
% 
% solucion = matriz \ lado_derecho;
% 
% plot_sol(solucion, front1, front2, front3, front4, intervalos);

figure
sol_jac = zeros([(intervalos-1)^2, 1]);
for i = 1 : 5000
    disp(i)
    sol_jac = siguiente_jacobi(sol_jac, lado_derecho, intervalos);
    plot_sol(sol_jac, front1, front2, front3, front4, intervalos);
    
    ax = gca;
    ax.ZLim = [-2, 2];
    drawnow
end
% plot_sol(sol_jac, front1, front2, front3, front4, intervalos);

