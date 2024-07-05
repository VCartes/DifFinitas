
% Genera cuatro vectores con datos en la frontera, front1 contiene los
% datos en x = 0, front2 en y = 1, front3 en x = 1, front4 en y = 0

function [front1, front2, front3, front4] = gen_datos_frontera(g, ...
   intervalos)

h = 1 / intervalos;

front1 = g(0, 0 : h : 1)';
front2 = g(0 : h : 1, 1)';
front3 = g(1, 0 : h : 1)';
front4 = g(0 : h : 1, 0)';
end