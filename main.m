close all
clearvars

% f = @(x, y) 0 * x .* y + 1;
% g = @(x, y) 0 *x .* y;

f = @(x, y) 200*(x.^2 + y.^2);
g = @(x, y) exp(pi * y) * cos(pi * x) + 20 * exp(-pi * y) * cos(pi * x);

% f = @(x, y) -8*pi^2 * sin(2*pi*x) .* sin(2*pi*y);
% g = @(x, y) 0.*x.*y;

intervalos = 100;

[front1, front2, front3, front4] = gen_datos_frontera(g, intervalos);

lado_derecho = gen_lado_derecho(f, front1, front2, front3, ...
   front4, intervalos);

matriz = gen_matriz(intervalos);

figure
sol = zeros([(intervalos-1)^2, 1]);

for i = 1 : 50000
    % disp(i)
    sol = siguiente_jacobi(sol, lado_derecho, intervalos);
    % sol = siguiente_sor(sol, lado_derecho, 0.5, intervalos);

    % plot_sol(sol, front1, front2, front3, front4, intervalos);
    
    % ax = gca;
    % ax.ZLim = [-2, 2];
    % drawnow

    if mod(i, 100) == 0
        if debe_parar(sol, lado_derecho, intervalos)
            break
        end
    end
end
i
real = matriz \ lado_derecho;
norm(sol - real)
norm(sol - real) / norm(real)

plot_sol(sol, front1, front2, front3, front4, intervalos);

% ax = gca;
% ax.YLim = [0, 2];
% ax.ZLim = [-2, 2];
