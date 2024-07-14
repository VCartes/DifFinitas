close all
clearvars

% ---------------------- ARCHIVO PRINCIPAL ----------------------------

INTERVALOS = 500;


% ----------- PROBLEMAS -----------

% f = @(x, y) 8*pi^2 * sin(2*pi*x) .* sin(2*pi*y);
% g = @(x, y) 0.*x.*y;
% u = @(x, y) sin(2*pi*x) .* sin(2*pi*y);

f = @(x, y) -2 * (exp(x) + exp(1 - x)) .* (exp(y) + exp(1 - y));
g = @(x, y) (exp(x) + exp(1 - x)) .* (exp(y) + exp(1 - y));
u = @(x, y) (exp(x) + exp(1 - x)) .* (exp(y) + exp(1 - y));


% ----------- VARIABLES -----------

h = 1 / INTERVALOS;

[front1, front2, front3, front4] = gen_datos_frontera(g, h);

lado_derecho = gen_lado_derecho(f, front1, front2, front3, ...
   front4, INTERVALOS);

w_optimo = 2 / (1 + sqrt(1 - cos(pi * h)^2));

fig = figure;
fig.Position(1:2) = [20, 60];
fig.Position(3:4) = [900, 900];

sol = zeros([(INTERVALOS-1)^2, 1]);


% ----------- ITERACIONES -----------

for i = 1 : 10000
    
    % Elegir metodo
    % sol = siguiente_jacobi(sol, lado_derecho, INTERVALOS);
    sol = siguiente_sor(sol, lado_derecho, w_optimo, INTERVALOS);


    % Descomentar para ver solución en proceso
    % plot_sol(sol, front1, front2, front3, front4, INTERVALOS);
    % drawnow


    % Condición de parada
    if mod(i, 100) == 0
        if debe_parar(sol, lado_derecho, INTERVALOS)
            break
        end
    end
end


% ----------- PLOT Y COMPARAR -----------

fprintf("\nIntervalos: %d.\n", INTERVALOS);
fprintf("Se realizaron %d iteraciones.\n", i);

archivo = sprintf("Imagenes/P2-SOR-%d.png", INTERVALOS);

plot_sol(sol, front1, front2, front3, front4, INTERVALOS);
ax = gca;
ax.ZLim = [0, 14];
% exportgraphics(fig, archivo);

sol_real = vector_sol_real(u, INTERVALOS);
dif = max(abs(sol - sol_real)) / max(abs(sol_real));

fprintf("Error relativo entre aproximación y solución: %.3e.\n\n", dif);
